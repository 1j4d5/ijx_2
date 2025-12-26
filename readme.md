---
format-detection: telephone=no
generator: MediaWiki 1.39.7
lang: en
title: CPU Registers x86 - OSDev Wiki
viewport: width=1000
---

::: {#mw-page-base .noprint}
:::

::: {#mw-head-base .noprint}
:::

::: {#content .mw-body .ve-init-mw-desktopArticleTarget-targetContainer role="main"}
[]{#top}

::: {#siteNotice}
:::

::: mw-indicators
:::

# [CPU Registers x86]{.mw-page-title-main} {#firstHeading .firstHeading .mw-first-heading}

::: {#bodyContent .vector-body}
::: {#siteSub .noprint}
From OSDev Wiki
:::

::: {#contentSub}
:::

::: {#contentSub2}
:::

::: {#jump-to-nav}
:::

[Jump to
navigation](https://wiki.osdev.org/CPU_Registers_x86#mw-head){.mw-jump-link}
[Jump to
search](https://wiki.osdev.org/CPU_Registers_x86#searchInput){.mw-jump-link}

::: {#mw-content-text .mw-body-content .mw-content-ltr lang="en" dir="ltr"}
::: mw-parser-output
::: {#toc .toc role="navigation" aria-labelledby="mw-toc-heading"}
::: {.toctitle lang="en" dir="ltr"}
## Contents {#mw-toc-heading}

[]{.toctogglespan}
:::

-   [[1]{.tocnumber} [General Purpose
    Registers]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#General_Purpose_Registers)
-   [[2]{.tocnumber} [Pointer
    Registers]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#Pointer_Registers)
-   [[3]{.tocnumber} [Segment
    Registers]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#Segment_Registers)
-   [[4]{.tocnumber} [EFLAGS
    Register]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#EFLAGS_Register)
-   [[5]{.tocnumber} [Control
    Registers]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#Control_Registers)
    -   [[5.1]{.tocnumber}
        [CR0]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#CR0)
    -   [[5.2]{.tocnumber}
        [CR1]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#CR1)
    -   [[5.3]{.tocnumber}
        [CR2]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#CR2)
    -   [[5.4]{.tocnumber}
        [CR3]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#CR3)
    -   [[5.5]{.tocnumber}
        [CR4]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#CR4)
    -   [[5.6]{.tocnumber} [CR5 -
        CR7]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#CR5_-_CR7)
    -   [[5.7]{.tocnumber}
        [CR8]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#CR8)
-   [[6]{.tocnumber} [Extended Control
    Registers]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#Extended_Control_Registers)
    -   [[6.1]{.tocnumber}
        [XCR0]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#XCR0)
-   [[7]{.tocnumber} [Debug
    Registers]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#Debug_Registers)
    -   [[7.1]{.tocnumber} [DR0 -
        DR3]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#DR0_-_DR3)
    -   [[7.2]{.tocnumber}
        [DR6]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#DR6)
    -   [[7.3]{.tocnumber}
        [DR7]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#DR7)
-   [[8]{.tocnumber} [Test
    Registers]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#Test_Registers)
-   [[9]{.tocnumber} [Protected Mode
    Registers]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#Protected_Mode_Registers)
    -   [[9.1]{.tocnumber}
        [GDTR]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#GDTR)
    -   [[9.2]{.tocnumber}
        [LDTR]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#LDTR)
    -   [[9.3]{.tocnumber}
        [IDTR]{.toctext}](https://wiki.osdev.org/CPU_Registers_x86#IDTR)
:::

## [General Purpose Registers]{#General_Purpose_Registers .mw-headline}

  -------- -------- -------- ------------- ------------ --------------------
  64-bit   32-bit   16-bit   8 high bits   8 low bits   Description
  RAX      EAX      AX       AH            AL           Accumulator
  RBX      EBX      BX       BH            BL           Base
  RCX      ECX      CX       CH            CL           Counter
  RDX      EDX      DX       DH            DL           Data
  RSI      ESI      SI       N/A           SIL          Source
  RDI      EDI      DI       N/A           DIL          Destination
  RSP      ESP      SP       N/A           SPL          Stack Pointer
  RBP      EBP      BP       N/A           BPL          Stack Base Pointer
  -------- -------- -------- ------------- ------------ --------------------

## [Pointer Registers]{#Pointer_Registers .mw-headline}

  -------- -------- -------- ---------------------
  64-bit   32-bit   16-bit   Description
  RIP      EIP      IP       Instruction Pointer
  -------- -------- -------- ---------------------

## [Segment Registers]{#Segment_Registers .mw-headline}

  -------- ---------------------------
  16-bit   Description
  CS       Code Segment
  DS       Data Segment
  ES       Extra Segment
  SS       Stack Segment
  FS       General Purpose F Segment
  GS       General Purpose G Segment
  -------- ---------------------------

## [EFLAGS Register]{#EFLAGS_Register .mw-headline}

  ------- ------- -------------------------------
  Bit     Label   Description
  0       CF      Carry flag
  2       PF      Parity flag
  4       AF      Auxiliary flag
  6       ZF      Zero flag
  7       SF      Sign flag
  8       TF      Trap flag
  9       IF      Interrupt enable flag
  10      DF      Direction flag
  11      OF      Overflow flag
  12-13   IOPL    I/O privilege level
  14      NT      Nested task flag
  16      RF      Resume flag
  17      VM      Virtual 8086 mode flag
  18      AC      Alignment check
  19      VIF     Virtual interrupt flag
  20      VIP     Virtual interrupt pending
  21      ID      Able to use CPUID instruction
  ------- ------- -------------------------------

Unlisted bits are reserved.

## [Control Registers]{#Control_Registers .mw-headline}

#### [CR0]{#CR0 .mw-headline}

  ----- ------- -----------------------
  Bit   Label   Description
  0     PE      Protected Mode Enable
  1     MP      Monitor co-processor
  2     EM      x87 FPU Emulation
  3     TS      Task switched
  4     ET      Extension type
  5     NE      Numeric error
  16    WP      Write protect
  18    AM      Alignment mask
  29    NW      Not-write through
  30    CD      Cache disable
  31    PG      Paging
  ----- ------- -----------------------

NOTE: This register is the only control register that can be written and
read via 2 ways unlike the other that can be accessed only via the MOV
instruction

::: {.mw-highlight .mw-highlight-lang-asm .mw-content-ltr dir="ltr"}
    ; First way:
    ; Write:
    mov cr0, reg

    ; Read:
    mov reg, cr0
    ; ----------------------
    ; Second way:
    ; Write:
    lmsw reg

    ; Read:
    smsw reg
:::

#### [CR1]{#CR1 .mw-headline}

Reserved, the CPU will throw a #UD exception when trying to access it.

#### [CR2]{#CR2 .mw-headline}

  ----------- ------- ---------------------------
  Bit         Label   Description
  0-31 (63)   PFLA    Page Fault Linear Address
  ----------- ------- ---------------------------

#### [CR3]{#CR3 .mw-headline}

  ------------ ------- ------------------------------ ------------------------------------------------------- -------------------------------------------------------------------------
  Bit          Label   Description                    [PAE](https://wiki.osdev.org/PAE "PAE"){.mw-redirect}   [Long Mode](https://wiki.osdev.org/Long_Mode "Long Mode"){.mw-redirect}
  3            PWT     Page-level Write-Through       (Not used)                                              (Not used if bit 17 of CR4 is 1)
  4            PCD     Page-level Cache Disable       (Not used)                                              (Not used if bit 17 of CR4 is 1)
  12-31 (63)   PDBR    Page Directory Base Register   Base of PDPT                                            Base of PML4T/PML5T
  ------------ ------- ------------------------------ ------------------------------------------------------- -------------------------------------------------------------------------

Bits 0-11 of the physical base address are assumed to be 0. Bits 3 and 4
of CR3 are only used when accessing a PDE in 32-bit paging without PAE.

#### [CR4]{#CR4 .mw-headline}

  ----- ------------ -----------------------------------------------------------------------------------------------------------------------------------
  Bit   Label        Description
  0     VME          Virtual 8086 Mode Extensions
  1     PVI          Protected-mode Virtual Interrupts
  2     TSD          Time Stamp Disable
  3     DE           Debugging Extensions
  4     PSE          Page Size Extension
  5     PAE          Physical Address Extension
  6     MCE          Machine Check Exception
  7     PGE          Page Global Enabled
  8     PCE          Performance-Monitoring Counter enable
  9     OSFXSR       Operating system support for FXSAVE and FXRSTOR instructions
  10    OSXMMEXCPT   Operating System Support for Unmasked SIMD Floating-Point Exceptions
  11    UMIP         User-Mode Instruction Prevention (if set, #GP on SGDT, SIDT, SLDT, SMSW, and STR instructions when CPL \> 0)
  12    LA57         57-bit linear addresses (if set, the processor uses 5-level paging otherwise it uses uses 4-level paging)
  13    VMXE         Virtual Machine Extensions Enable
  14    SMXE         Safer Mode Extensions Enable
  16    FSGSBASE     Enables the instructions RDFSBASE, RDGSBASE, WRFSBASE, and WRGSBASE
  17    PCIDE        PCID Enable
  18    OSXSAVE      XSAVE and Processor Extended States Enable
  20    SMEP         [Supervisor Mode Execution Protection](https://wiki.osdev.org/Supervisor_Memory_Protection "Supervisor Memory Protection") Enable
  21    SMAP         [Supervisor Mode Access Prevention](https://wiki.osdev.org/Supervisor_Memory_Protection "Supervisor Memory Protection") Enable
  22    PKE          Protection Key Enable
  23    CET          Control-flow Enforcement Technology
  24    PKS          Enable Protection Keys for Supervisor-Mode Pages
  ----- ------------ -----------------------------------------------------------------------------------------------------------------------------------

#### [CR5 - CR7]{#CR5_-_CR7 .mw-headline}

Reserved, same case as CR1.

#### [CR8]{#CR8 .mw-headline}

  ----- ------- ---------------------
  Bit   Label   Description
  0-3   TPL     Task Priority Level
  ----- ------- ---------------------

## [Extended Control Registers]{#Extended_Control_Registers .mw-headline}

#### [XCR0]{#XCR0 .mw-headline}

  ----- ----------- ---------------------------------------------------------------------------
  Bit   Label       Description
  0     X87         x87 FPU/MMX support (must be 1)
  1     SSE         XSAVE support for MXCSR and XMM registers
  2     AVX         AVX enabled and XSAVE support for upper halves of YMM registers
  3     BNDREG      MPX enabled and XSAVE support for BND0-BND3 registers
  4     BNDCSR      MPX enabled and XSAVE support for BNDCFGU and BNDSTATUS registers
  5     opmask      AVX-512 enabled and XSAVE support for opmask registers k0-k7
  6     ZMM_Hi256   AVX-512 enabled and XSAVE support for upper halves of lower ZMM registers
  7     Hi16_ZMM    AVX-512 enabled and XSAVE support for upper ZMM registers
  9     PKRU        XSAVE support for PKRU register
  ----- ----------- ---------------------------------------------------------------------------

XCR0 can only be accessed if bit 18 of CR4 is set to 1. XGETBV and
XSETBV instructions are used to access XCR0.

## [Debug Registers]{#Debug_Registers .mw-headline}

#### [DR0 - DR3]{#DR0_-_DR3 .mw-headline}

Contain linear addresses of up to 4 breakpoints. If paging is enabled,
they are translated to physical addresses.

#### [DR6]{#DR6 .mw-headline}

It permits the debugger to determine which debug conditions have
occurred.\
Bits 0 through 3 indicates, when set, that it\'s associated breakpoint
condition was met when a debug exception was generated.\
Bit 13 indicates that the next instruction in the instruction stream
accesses one of the debug registers.\
Bit 14 indicates (when set) that the debug exception was triggered by
the single-step execution mode (enabled with TF bit in EFLAGS).\
Bit 15 indicates (when set) that the debug instruction resulted from a
task switch where T flag in the TSS of target task was set.\
Bit 16 indicates (when clear) that the debug exception or breakpoint
exception occured inside an RTM region.\

#### [DR7]{#DR7 .mw-headline}

  ------- ------------------------
  Bit     Description
  0       Local DR0 breakpoint
  1       Global DR0 breakpoint
  2       Local DR1 breakpoint
  3       Global DR1 breakpoint
  4       Local DR2 breakpoint
  5       Global DR2 breakpoint
  6       Local DR3 breakpoint
  7       Global DR3 breakpoint
  16-17   Conditions for DR0
  18-19   Size of DR0 breakpoint
  20-21   Conditions for DR1
  22-23   Size of DR1 breakpoint
  24-25   Conditions for DR2
  26-27   Size of DR2 breakpoint
  28-29   Conditions for DR3
  30-31   Size of DR3 breakpoint
  ------- ------------------------

A local breakpoint bit deactivates on hardware task switches, while a
global does not.\
Condition 00b means execution break, 01b means a write watchpoint, and
11b means an R/W watchpoint. 10b is reserved for I/O R/W (unsupported).

## [Test Registers]{#Test_Registers .mw-headline}

  ----------- -----------------------
  Name        Description
  TR3 - TR5   Undocumented
  TR6         Test command register
  TR7         Test data register
  ----------- -----------------------

## [Protected Mode Registers]{#Protected_Mode_Registers .mw-headline}

#### [GDTR]{#GDTR .mw-headline}

  ------- ------- ---------------------------------------------------------------------------
  Bits    Label   Description
  0-15    Limit   (Size of [GDT](https://wiki.osdev.org/GDT "GDT"){.mw-redirect}) - 1
  16-47   Base    Starting address of [GDT](https://wiki.osdev.org/GDT "GDT"){.mw-redirect}
  ------- ------- ---------------------------------------------------------------------------

Stores the segment selector of the
[GDT](https://wiki.osdev.org/GDT "GDT"){.mw-redirect}.

#### [LDTR]{#LDTR .mw-headline}

  ------- ------- ---------------------------------------------------------------------------
  Bits    Label   Description
  0-15    Limit   (Size of [LDT](https://wiki.osdev.org/LDT "LDT"){.mw-redirect}) - 1
  16-47   Base    Starting address of [LDT](https://wiki.osdev.org/LDT "LDT"){.mw-redirect}
  ------- ------- ---------------------------------------------------------------------------

Stores the segment selector of the
[LDT](https://wiki.osdev.org/LDT "LDT"){.mw-redirect}.

#### [IDTR]{#IDTR .mw-headline}

  ------- ------- ---------------------------------------------------------------------------
  Bits    Label   Description
  0-15    Limit   (Size of [IDT](https://wiki.osdev.org/IDT "IDT"){.mw-redirect}) - 1
  16-47   Base    Starting address of [IDT](https://wiki.osdev.org/IDT "IDT"){.mw-redirect}
  ------- ------- ---------------------------------------------------------------------------

Stores the segment selector of the
[IDT](https://wiki.osdev.org/IDT "IDT"){.mw-redirect}.
:::

::: {.printfooter nosnippet=""}
Retrieved from
\"[https://wiki.osdev.org/index.php?title=CPU_Registers_x86&oldid=29246](https://wiki.osdev.org/index.php?title=CPU_Registers_x86&oldid=29246){dir="ltr"}\"
:::
:::

::: {#catlinks .catlinks mw="interface"}
::: {#mw-normal-catlinks .mw-normal-catlinks}
[Categories](https://wiki.osdev.org/Special:Categories "Special:Categories"):

-   [Pages using deprecated source
    tags](https://wiki.osdev.org/Category:Pages_using_deprecated_source_tags "Category:Pages using deprecated source tags")
-   [X86
    CPU](https://wiki.osdev.org/Category:X86_CPU "Category:X86 CPU")
-   [CPU
    Registers](https://wiki.osdev.org/Category:CPU_Registers "Category:CPU Registers")
:::
:::
:::
:::

::: {#mw-navigation}
## Navigation menu

::: {#mw-head}
### [Personal tools]{.vector-menu-heading-label} {#p-personal-label .vector-menu-heading}

::: vector-menu-content
-   [[Log
    in](https://wiki.osdev.org/index.php?title=Special:UserLogin&returnto=CPU+Registers+x86 "You are encouraged to log in; however, it is not mandatory [alt-shift-o]"){accesskey="o"}]{#pt-login}
-   [[Dark
    mode](https://wiki.osdev.org/CPU_Registers_x86#){.ext-darkmode-link}]{#pt-darkmode}
:::

::: {#left-navigation}
### [Namespaces]{.vector-menu-heading-label} {#p-namespaces-label .vector-menu-heading}

::: vector-menu-content
-   [[Page](https://wiki.osdev.org/CPU_Registers_x86 "View the content page [alt-shift-c]"){accesskey="c"}]{#ca-nstab-main}
-   [[Discussion](https://wiki.osdev.org/index.php?title=Talk:CPU_Registers_x86&action=edit&redlink=1 "Discussion about the content page (page does not exist) [alt-shift-t]"){rel="discussion"
    accesskey="t"}]{#ca-talk}
:::

[English]{.vector-menu-heading-label}

::: vector-menu-content
:::
:::

::: {#right-navigation}
### [Views]{.vector-menu-heading-label} {#p-views-label .vector-menu-heading}

::: vector-menu-content
-   [[Read](https://wiki.osdev.org/CPU_Registers_x86)]{#ca-view}
-   [[View
    source](https://wiki.osdev.org/index.php?title=CPU_Registers_x86&action=edit "This page is protected.
    You can view its source [alt-shift-e]"){accesskey="e"}]{#ca-viewsource}
-   [[View
    history](https://wiki.osdev.org/index.php?title=CPU_Registers_x86&action=history "Past revisions of this page [alt-shift-h]"){accesskey="h"}]{#ca-history}
:::

[More]{.vector-menu-heading-label}

::: vector-menu-content
:::

::: {#p-search .vector-search-box-vue .vector-search-box-show-thumbnail .vector-search-box-auto-expand-width .vector-search-box role="search"}
<div>

### Search

::: {#simpleSearch .vector-search-box-inner search-loc="header-navigation"}
:::

</div>
:::
:::
:::

::: {#mw-panel}
::: {#p-logo role="banner"}
[](https://wiki.osdev.org/Main_Page "Visit the main page"){.mw-wiki-logo}
:::

### [Navigation]{.vector-menu-heading-label} {#p-navigation-label .vector-menu-heading}

::: vector-menu-content
-   [[Main
    Page](https://wiki.osdev.org/Main_Page "Visit the main page [alt-shift-z]"){accesskey="z"}]{#n-mainpage}
-   [[Forums](http://forum.osdev.org/ "About the project, what you can do, where to find things"){rel="nofollow"}]{#n-portal}
-   [[FAQ](https://wiki.osdev.org/Category:FAQ)]{#n-FAQ}
-   [[OS Projects](https://wiki.osdev.org/Projects)]{#n-OS-Projects}
-   [[Random
    page](https://wiki.osdev.org/Special:Random "Load a random page [alt-shift-x]"){accesskey="x"}]{#n-randompage}
:::

### [About]{.vector-menu-heading-label} {#p-about-label .vector-menu-heading}

::: vector-menu-content
-   [[This site](https://wiki.osdev.org/OSDevWiki:About)]{#n-This-site}
-   [[Joining](https://wiki.osdev.org/OSDevWiki:Joining)]{#n-Joining}
-   [[Editing
    help](https://wiki.osdev.org/OSDevWiki:Editing)]{#n-Editing-help}
-   [[Recent
    changes](https://wiki.osdev.org/Special:RecentChanges "A list of recent changes in the wiki [alt-shift-r]"){accesskey="r"}]{#n-recentchanges}
:::

### [Tools]{.vector-menu-heading-label} {#p-tb-label .vector-menu-heading}

::: vector-menu-content
-   [[What links
    here](https://wiki.osdev.org/Special:WhatLinksHere/CPU_Registers_x86 "A list of all wiki pages that link here [alt-shift-j]"){accesskey="j"}]{#t-whatlinkshere}
-   [[Related
    changes](https://wiki.osdev.org/Special:RecentChangesLinked/CPU_Registers_x86 "Recent changes in pages linked from this page [alt-shift-k]"){rel="nofollow"
    accesskey="k"}]{#t-recentchangeslinked}
-   [[Special
    pages](https://wiki.osdev.org/Special:SpecialPages "A list of all special pages [alt-shift-q]"){accesskey="q"}]{#t-specialpages}
-   [[Printable version]{rel="alternate" accesskey="p"}]{#t-print}
-   [[Permanent
    link](https://wiki.osdev.org/index.php?title=CPU_Registers_x86&oldid=29246 "Permanent link to this revision of this page")]{#t-permalink}
-   [[Page
    information](https://wiki.osdev.org/index.php?title=CPU_Registers_x86&action=info "More information about this page")]{#t-info}
:::
:::
:::

-   [This page was last edited on 25 September 2024, at
    09:06.]{#footer-info-lastmod}
-   [This page has been accessed 91,571 times.]{#footer-info-0}

```{=html}
<!-- -->
```
-   [[Privacy
    policy](https://wiki.osdev.org/OSDev_Wiki:Privacy_policy)]{#footer-places-privacy}
-   [[About OSDev
    Wiki](https://wiki.osdev.org/OSDev_Wiki:About)]{#footer-places-about}
-   [[Disclaimers](https://wiki.osdev.org/OSDev_Wiki:General_disclaimer)]{#footer-places-disclaimer}
-   [[Mobile
    view](https://wiki.osdev.org/index.php?title=CPU_Registers_x86&mobileaction=toggle_view_mobile){.noprint
    .stopMobileRedirectToggle}]{#footer-places-mobileview}

```{=html}
<!-- -->
```
-   [[![Powered by
    MediaWiki](https://wiki.osdev.org/resources/assets/poweredby_mediawiki_88x31.png){width="88"
    height="31"
    loading="lazy"}](https://www.mediawiki.org/)]{#footer-poweredbyico}
