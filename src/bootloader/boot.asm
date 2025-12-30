org 0x7C00                  ; setting origin to 0x7C00 
bits 16                     ; 16-bit code

%define ENDL 0x0A           ; newline character

; 
; FAT 12 header
; 
jmp short start        ; jump to start of code
nop                    ; no operation

bdb_oem:                    db 'MSWIN4.1'   ; OEM Name (8 bytes)
bdb_bytes_per_sector:       dw 512          ; Bytes per sector (2 bytes)
bdb_sectors_per_cluster:    db 1            ; Sectors per cluster (1 byte)
bdb_reserved_sectors:       dw 1            ; Reserved sectors (2 bytes)
bdb_fats_count:             db 2            ; Number of FATs (1 byte)
bdb_dir_entries_count:      dw 0E0h        ; Max number of root directory entries (2 bytes)
bdb_total_sectors_short:    dw 2880         ; Total sectors (2 bytes)
bdb_media_descriptor_type:  db 0F0h         ; Media descriptor (1 byte) F0 = 3.5 floppy disk
bdb_sectors_per_fat:        dw 9            ; Sectors per FAT (2 bytes)
bdb_sectors_per_track:      dw 18           ; Sectors per track (2 bytes)
bdb_heads:                  dw 2            ; Number of heads (2 bytes)
bdb_hidden_sectors:         dd 0            ; Hidden sectors (4 bytes)
bdb_large_sectors_count:    dd 0            ; Large total sectors (4 bytes)
;extended BIOS Parameter Block (BPB) / boot record
ebr_drive_number:           db 0            ; Drive number (1 byte) 
                            db 0            ; Reserved (1 byte)
ebr_signature:              db 29h            ; Reserved (1 byte)
ebr_volume_id:              db 67h, 67h, 67h, 67h    ; Volume ID (4 bytes)
ebr_volume_label:           db 'IJX2       ' ; Volume Label (11 bytes)
ebr_system_id:              db 'FAT12   '    ; File system type (8 bytes)
; 
;  end of FAT 12 header
;
                            ; main entry point
start:
                            ; always jump to main
    jmp main

; 
;   puts (print a string to the screen)
;   params:
;   ds:si points to string  
;- si: pointer to the string to print
;          
puts:
    push si                 ; save si
    push ax                 ; save ax
.loop:
    lodsb                   ; load byte at ds:si into al and increment si
    or al, al               ; check if al is 0 (end of string) it also store result of al in flags
    jz .done                ; if zero, we are done
    mov ah, 0x0E            ; teletype output function (VGA BIOS)
    int 0x10                ; call BIOS video interrupt

    jmp .loop               ; otherwise, keep looping
.done:
    pop ax                  ; restore ax
    pop si                  ; restore si
    ret                     ; return from puts
main:
    ; setup segments
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; store drive number from BIOS (passed in dl)
    mov [ebr_drive_number], dl

    ; attempt to read sector 1 (the sector after the bootloader)
    mov ax, 1                           ; LBA 1
    mov cl, 1                           ; 1 sector
    mov bx, 0x7E00                      ; destination: immediately after bootloader
    call disk_read

    ; print welcome message
    mov si, msg_hello
    call puts

    cli                                 ; disable interrupts before halting
    hlt          ; halt the CPU  

floppy_error:
    mov si, msg_read_failed ; load address of floppy error message into si
    call puts               ; call puts to print the error message
    jmp wait_key_and_reboot
    hlt                     ; halt the CPU

wait_key_and_reboot:
    ; wait for a key press
    mov ah, 0               ; BIOS keyboard function: wait for key press
    int 16h                ; call BIOS keyboard interrupt
    jmp 0FFFFh:0
    

.halt:
    cli
    hlt
    jmp .halt               ; infinite loop if the cpu resumes after hlt

; 
;  DISK routines
; 

; 
; LBA to CHS conversion
; 
;   Params:
;       ax: LBA address 
;   Returns:
;       cx [bbit 0-5]: sector number
;       cx [bit 6-15]: cylinder number
;       dh: head

lba_to_chs:
    push ax
    push dx

    xor dx, dx                          ; prepare dx:ax for division
    div word [bdb_sectors_per_track]    ; ax = LBA / SPT, dx = LBA % SPT
    
    inc dx                              ; Sector = (LBA % SPT) + 1
    mov cx, dx                          ; cx = sector (bits 0-5)

    xor dx, dx                          ; prepare dx:ax
    div word [bdb_heads]                ; ax = cylinder, dx = head

    ; Now: ax = cylinder, dx = head, cx = sector
    mov dh, dl                          ; dh = head number
    mov ch, al                          ; ch = cylinder lower 8 bits
    shl ah, 6                           ; move top 2 bits of cylinder to bits 6-7
    or cl, ah                           ; combine with sector bits

    pop ax
    mov dl, al                          ; restore drive number into dl (from original push ax/dx logic)
    pop ax                              ; cleaning up the stack correctly
    ret


; 
; READ SECTOR FROM DISK
; Params:
;   ax: LBA address
;   cl: number of sectors to read (up to 128)
;   dl: drive number (0x00 for first floppy) 
;  es:bx: pointer to buffer to read into (memory address where to store data)
;
disk_read:
    push ax                             ; save registers
    push bx
    push cx
    push dx
    push di

    push cx                             ; save sector count (cl)
    call lba_to_chs                     ; convert LBA (ax) to CHS
    pop ax                              ; al = number of sectors to read
    mov ah, 02h                         ; BIOS read function
    mov di, 3                           ; retry count

.retry:
    pusha                               ; save all registers for the BIOS call
    stc                                 ; some BIOS need carry set
    int 13h                             ; BIOS interrupt
    jnc .done                           ; if carry clear, success!

    ; Failed:
    popa                                ; restore registers to try again
    call disk_reset                     ; reset disk controller
    dec di
    jnz .retry                          ; loop back to .retry, not a recursive call

.fail:
    jmp floppy_error                    ; after 3 attempts, give up

.done:
    popa                                ; restore the pusha from the loop
    pop di                              ; restore original registers in REVERSE order
    pop dx
    pop cx
    pop bx
    pop ax
    ret
;
; DISK reset controller
;

disk_reset:
    pusha
    mov ah, 0
    stc
    int 13h
    jc floppy_error
    popa
    ret




msg_hello: db 'WELCOME to LIFE IJx 2!', ENDL, 0
msg_read_failed: db 'READ FROM FLOPPY FAILED!', ENDL, 0
times 510-($-$$) db 0       ; 510-(size of the file) * 0 so it fills with 0s
dw 0xAA55                   ; boot signature