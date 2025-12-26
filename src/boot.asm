org 0x7C00
bits 16



main:
    hlt
  
.halt:
    jmp .halt

times 510-($-$$) db 0       ; 510-(size of the file) * 0 so it fills with 0s
dw 0xAA55