AS := "aarch64-linux-gnu-as"
CC := "aarch64-linux-gnu-gcc"
OBJCOPY := "aarch64-linux-gnu-objcopy"
LD := "aarch64-linux-gnu-gcc"
IMG := "kernel8"
ELF := "babyos"
BOOT_OBJ := "boot"
KERNEL_OBJ := "kernel"
TARGET := "raspi4b"

default: clean build qemu

build: assemble-bootloader compile-kernel link

assemble-bootloader:
    @{{ AS }} -o {{ BOOT_OBJ }}.o {{ BOOT_OBJ }}.s

compile-kernel:
    @{{ CC }} -ffreestanding -O2 -Wall -Wextra -c {{ KERNEL_OBJ }}.c -o {{ KERNEL_OBJ }}.o

link:
    @{{ LD }} -T linker.ld -ffreestanding -O2 -nostdlib -o {{ ELF }}.elf {{ BOOT_OBJ }}.o {{ KERNEL_OBJ }}.o
    {{ OBJCOPY }} {{ ELF }}.elf -O binary {{ IMG }}.img

clean:
    @rm -f {{ BOOT_OBJ }}.o {{ KERNEL_OBJ }}.o {{ ELF }}.elf {{ IMG }}.img

qemu:
    @qemu-system-aarch64 -machine {{ TARGET }} -kernel {{ IMG }}.img -display none -serial stdio
