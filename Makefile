AS      = aarch64-linux-gnu-as
CC      = aarch64-linux-gnu-gcc
OBJCOPY = aarch64-linux-gnu-objcopy
LD      = $(CC)

CFLAGS  = -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T linker.ld -ffreestanding -O2 -nostdlib

TARGET  = kernel8.img
ELF     = babyos.elf
OBJS    = boot.o kernel.o

.PHONY: all clean test qemu

all: $(TARGET)

boot.o: boot.s
	$(AS) -o $@ $<

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

$(ELF): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS) -lgcc

$(TARGET): $(ELF)
	$(OBJCOPY) $< -O binary $@

clean:
	rm -f $(OBJS) $(ELF) $(TARGET)

qemu: $(TARGET)
	qemu-system-aarch64 -M raspi4b -kernel $(TARGET) -display none -serial stdio
