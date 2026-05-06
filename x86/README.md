# Baby OS
An OS made by babies.

# Running
There is a run script, that will assemble and mount into qemu.

## Prerequisites
Go google how to install it.
- NASM
- QEMU

# Design
- Bootloader: 512 bytes, loads the kernel into memory and jumps to it.
- Kernel: Treats kestrikes as an interrupt and outputs the offset to the screen. But doesn't clear anything.
- BIOS: Uses BIOS (not UEFI). Easist approach is to use Qemu with SeaBIOS.

# Inspect the Registers
You can get a snapshot of the registers while interacting by running `info registers` in the terminal. Qemu will print out the current values of all the registers. This can be useful for debugging and understanding how the program is executing.

# Refrences
- [OS Dev: Baby Steps](https://wiki.osdev.org/Category:Babystep)
