nasm boot.asm -f bin -o boot.bin

qemu-system-x86_64 \
-name "Baby OS" \
-drive format=raw,file=boot.bin \
-monitor stdio
