// AArch64 mode
//aarch64-linux-gnu-as -o boot.o boot.s
// To keep this in the first portion of the binary.
.section ".text.boot"

// Make _start global.
.global _start // the linker script is set to 0x80000
_start:
    // set stack before our code
    ldr     x5, =_start
    mov     sp, x5

    // clear block starting symbol: https://en.wikipedia.org/wiki/.bss
    ldr     x5, =__bss_start
    ldr     w6, =__bss_size
1:  cbz     w6, 2f
    str     xzr, [x5], #8
    sub     w6, w6, #1
    cbnz    w6, 1b

    // jump to C code, should not return
2:  bl      kernel_main
    // for failsafe, halt this core
halt:
    wfe
    b halt
