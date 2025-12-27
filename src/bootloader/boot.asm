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
                            ; setup data segment
    mov ax, 0               ; set ax to 0 because we want to set ds and es to 0  
    mov ds, ax
    mov es, ax
                            ; setting stack segment to o 
    mov ss, ax
    mov sp, 0x7C00          ; setting stack pointer to (0x7COO)start stack grows downwards: follows FIFO(first in first out)     

    mov [ebr_drive_number], dl
    mov ax, 1
    mov cl, 1
    mov bx, 0x7E00
    call disk_read

                            ; print welcome message

    mov si, msg_hello       ; load address of msg_hello into si                          
    call puts               ; call puts to print the message                  
    hlt                     ; halt the CPU  

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
    push ax              ; save ax
    push dx              ; save dx

    xor dx, dx           ; clear dx or dx=0
    div word [bdb_sectors_per_track] ; ax=LBA /  sectors per track
                                        ;dx = LBA % sectors per track
    inc dx               ; dx= LBA / sectorpertrack  + 1
    mov cx, dx          ; move remainder to cx (sector number) cx = sector number

    xor dx, dx          ; clear dx
    div word [bdb_heads] ; ax = (LBA / sector per traack) / heads
                            ; dx = (LBA / sector per track) % heads

    ; seting the values to correct registers
    mov dh, dl          ; head number to dh
    mov cl, al          ; cylinder number to cl (lower 8 bits)
    shl ah, 6         ; shift upper 2 bits of cylinder number to upper bits of ah
    or cl, ah          ; combine lower and upper bits of cylinder number
    pop ax
    mov dl, al
    pop dx
    ret                    ; return from lba_to_chs 


; 
; READ SECTOR FROM DISK
; Params:
;   ax: LBA address
;   cl: number of sectors to read (up to 128)
;   dl: drive number (0x00 for first floppy) 
;  es:bx: pointer to buffer to read into (memory address where to store data)
;
disk_read:
    push ax               ; save ax (LBA address)
    push bx              ; save bx (buffer pointer)
    push cx             ; save cx (number of sectors to read)
    push dx              ; save dx (drive number)
    push di              ; save di (retry count)

    push cx              ; save cx (temp save cl:number of sectors to read)
    call lba_to_chs      ; convert LBA to CHS
    pop ax               ; restore ax (LBA address) AL = number of sectors to read
    mov ah, 02h          ; BIOS read sectors function
    mov di, 3           ; retry count


.retry:
    pusha           ; save all registers 
    stc               ; set carry flag before calling BIOS (some BIOS require it)
    int 13h              ; call BIOS disk interrupt | if the carry flag is cleard, the operation was successful
    jnc .done         ; if no error, we are done
    ;failed to read, retry

    popa              ; restore all registers
    call disk_read

    dec di        ; decrement retry count
    test di, di      ; check if retry count is 0
    jnz .retry       ; if not zero, retry


.fail:
    ; handle failure (could print error message or halt) all attempts are exhausted
    jmp floppy_error    
.done:
    popa          ; restore all registers
    pop di              ; restore ax (LBA address)
    pop dx              ; restore bx (buffer pointer)
    pop cx             ; restore cx (number of sectors to read)
    pop bx              ; restore dx (drive number)
    pop ax              ; restore di (retry count)
    ret                 ; return from disk_read

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