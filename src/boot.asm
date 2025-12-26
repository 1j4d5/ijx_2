org 0x7C00                  ; setting origin to 0x7C00 
bits 16                     ; 16-bit code

%define ENDL 0x0A           ; newline character


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

                            ; print welcome message

    mov si, msg_hello       ; load address of msg_hello into si                          
    call puts               ; call puts to print the message                  
    hlt                     ; halt the CPU  
  
.halt:
    jmp .halt               ; infinite loop if the cpu resumes after hlt



msg_hello: db 'WELCOME to LIFE IJx 2!', ENDL, 0
times 510-($-$$) db 0       ; 510-(size of the file) * 0 so it fills with 0s
dw 0xAA55                   ; boot signature