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
# Current Progress

- [x] Created the empty OS layout
- [x] BIOS Change to 16bit
- [x] Welcome to life: IJx 2!
- [ ] Change to disk (adding disk register bits so it support FAT)
- [ ] Setting up FAT12 with FAT registers
 
**NOTE:** ERROR ON BOOTLOADER THE BOOTLOADER GET STUCK (PROLLY MEMORY ISSUES (IWILL FIX IT LATER))
---    
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

## BIOS Parameter Block (BPB)

| Offset (Dec) | Offset (Hex) | Size (Bytes) | Meaning                                                                                                                                                                                                                                   |
| ------------ | ------------ | ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 0            | 0x00         | 3            | Jump instruction (typically `EB 3C 90` → `JMP SHORT 3C` + `NOP`) to skip over BPB/EBPB data. Prevents execution of non-code data. Required by Windows and macOS. An infinite loop like `EB FE 90` is acceptable for non-bootable volumes. |
| 3            | 0x03         | 8            | OEM Identifier string (e.g. `MSWIN4.1`, `MSDOS5.1`, `mkdosfs`, `FRDOS5.1`). Largely ignored by MS FAT drivers but some third-party drivers expect a valid value. Padded with spaces.                                                      |
| 11           | 0x0B         | 2            | Bytes per sector (little-endian).                                                                                                                                                                                                         |
| 13           | 0x0D         | 1            | Sectors per cluster.                                                                                                                                                                                                                      |
| 14           | 0x0E         | 2            | Reserved sectors (includes boot sector).                                                                                                                                                                                                  |
| 16           | 0x10         | 1            | Number of FATs (commonly 2).                                                                                                                                                                                                              |
| 17           | 0x11         | 2            | Number of root directory entries (must align to whole sectors).                                                                                                                                                                           |
| 19           | 0x13         | 2            | Total sectors (if 0, use large sector count at 0x20).                                                                                                                                                                                     |
| 21           | 0x15         | 1            | Media descriptor type.                                                                                                                                                                                                                    |
| 22           | 0x16         | 2            | Sectors per FAT (FAT12/FAT16 only).                                                                                                                                                                                                       |
| 24           | 0x18         | 2            | Sectors per track (geometry; unreliable).                                                                                                                                                                                                 |
| 26           | 0x1A         | 2            | Number of heads (geometry; unreliable).                                                                                                                                                                                                   |
| 28           | 0x1C         | 4            | Hidden sectors (LBA of partition start).                                                                                                                                                                                                  |
| 32           | 0x20         | 4            | Large sector count (used if total sectors > 65535).                                                                                                                                                                                       |

> **Note:** Disk geometry values (SPT, heads, bytes/sector) may be incorrect. Prefer BIOS-provided values.
>
> **Note 2:** Many BPB fields are misaligned. On architectures that fault on misaligned access, copy the BPB to an aligned buffer before reading multi-byte fields.

---

## Extended Boot Record (EBPB)

### FAT12 / FAT16

| Offset (Dec) | Offset (Hex) | Size (Bytes) | Meaning                                                                                                          |
| ------------ | ------------ | ------------ | ---------------------------------------------------------------------------------------------------------------- |
| 36           | 0x24         | 1            | Drive number (0x00 = floppy, 0x80 = HDD). Matches BIOS `INT 13h` DL value; generally unreliable across machines. |
| 37           | 0x25         | 1            | Reserved / Windows NT flags.                                                                                     |
| 38           | 0x26         | 1            | Signature (must be `0x28` or `0x29`).                                                                            |
| 39           | 0x27         | 4            | Volume ID (serial number).                                                                                       |
| 43           | 0x2B         | 11           | Volume label (space-padded).                                                                                     |
| 54           | 0x36         | 8            | System identifier string (e.g. `FAT12`, `FAT16`). Should not be trusted for logic.                               |
| 62           | 0x3E         | 448          | Boot code.                                                                                                       |
| 510          | 0x1FE        | 2            | Boot sector signature `0xAA55`.                                                                                  |


# disk layout
![Disk Mechanism](https://www.cs.uic.edu/~jbell/CourseNotes/OperatingSystems/images/Chapter10/10_01_DiskMechanism.jpg)

## The bios we are working with (i386) only works with CHS so we have to make our own COM 
### LBA to CHS convertion 
- sector per track/cylinder (on a single side)
- heads per cylinder (or jst heads)
---
- sector = (LBA % sector per track)+1
- head = (LBA / sector per track) % heads
- cylinder = (LBA/sectors per track) / heads

