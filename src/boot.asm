org 0x7C00                  ; setting origin to 0x7C00 
bits 16                     ; 16-bit code



main:
    hlt                     ; halt the CPU  
  
.halt:
    jmp .halt               ; infinite loop if the cpu resumes after hlt

times 510-($-$$) db 0       ; 510-(size of the file) * 0 so it fills with 0s
dw 0xAA55