# IJx 2
---
To compile run: 
```bash
make
```
and then run it on vm
```bash
qemu-system-i386 -fda build/main_floppy.img
```            

# below is some common data addresses that i'll be using a lot
---
# CPU Registers (x86 / x86-64)

This document summarizes **x86 / x86-64 CPU registers**, their purposes, and relevant control, debug, and protected-mode structures.
Useful for **OS development**, **bootloaders**, and **low-level systems programming**.

---

## General Purpose Registers

| 64-bit | 32-bit | 16-bit | 8 high | 8 low | Description |
|------|------|------|------|------|-------------|
| RAX | EAX | AX | AH | AL | Accumulator |
| RBX | EBX | BX | BH | BL | Base |
| RCX | ECX | CX | CH | CL | Counter |
| RDX | EDX | DX | DH | DL | Data |
| RSI | ESI | SI | N/A | SIL | Source |
| RDI | EDI | DI | N/A | DIL | Destination |
| RSP | ESP | SP | N/A | SPL | Stack Pointer |
| RBP | EBP | BP | N/A | BPL | Stack Base Pointer |

---

## Pointer Registers

| 64-bit | 32-bit | 16-bit | Description |
|------|------|------|-------------|
| RIP | EIP | IP | Instruction Pointer |

---

## Segment Registers

| Register | Description |
|--------|-------------|
| CS | Code Segment |
| DS | Data Segment |
| ES | Extra Segment |
| SS | Stack Segment |
| FS | General Purpose F Segment |
| GS | General Purpose G Segment |

---

## EFLAGS Register

| Bit | Label | Description |
|---|---|---|
| 0 | CF | Carry flag |
| 2 | PF | Parity flag |
| 4 | AF | Auxiliary flag |
| 6 | ZF | Zero flag |
| 7 | SF | Sign flag |
| 8 | TF | Trap flag |
| 9 | IF | Interrupt enable flag |
| 10 | DF | Direction flag |
| 11 | OF | Overflow flag |
| 12–13 | IOPL | I/O privilege level |
| 14 | NT | Nested task flag |
| 16 | RF | Resume flag |
| 17 | VM | Virtual 8086 mode |
| 18 | AC | Alignment check |
| 19 | VIF | Virtual interrupt flag |
| 20 | VIP | Virtual interrupt pending |
| 21 | ID | CPUID instruction support |

> Unlisted bits are reserved.

---

## Control Registers

### CR0

| Bit | Label | Description |
|---|---|---|
| 0 | PE | Protected Mode Enable |
| 1 | MP | Monitor co-processor |
| 2 | EM | x87 FPU Emulation |
| 3 | TS | Task switched |
| 4 | ET | Extension type |
| 5 | NE | Numeric error |
| 16 | WP | Write protect |
| 18 | AM | Alignment mask |
| 29 | NW | Not-write through |
| 30 | CD | Cache disable |
| 31 | PG | Paging |

**Access methods**
```asm
; MOV method
mov cr0, reg
mov reg, cr0

; LMSW / SMSW method
lmsw reg
smsw reg
```

---

## Common BIOS Interrupts

| Interrupt | Purpose |
|---|---|
| INT 10h | Video services |
| INT 11h | Equipment check |
| INT 12h | Memory size |
| INT 13h | Disk services |
| INT 14h | Serial services |
| INT 15h | System services |
| INT 16h | Keyboard services |

