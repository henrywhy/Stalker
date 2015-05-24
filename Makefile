#create bootable iso image
stalker.iso: kernel.bin
	mkdir -p isodir/boot/grub
	cp kernel.bin isodir/boot/kernel.bin
	cp scripts/grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o stalker.iso isodir
	rm -rf isodir

#create Stalker OS Kernel
kernel.bin: kernel.o boot.o convert.o print.o scripts/link.lds
	ld kernel.o boot.o convert.o print.o -T scripts/link.lds -o kernel.bin -m elf_i386

#generate boot obj
boot.o: boot/boot.S
	gcc -Iinclude -nostdlib -fno-builtin  -Wall -c boot/boot.S -m32

#compile kernel
kernel.o: kernel/kernel.c
	gcc -Iinclude -nostdlib -fno-builtin  -Wall -c kernel/kernel.c -m32

#standard library about some print functions
print.o: lib/print.c
	gcc -Iinclude -nostdlib -fno-builtin  -Wall -c lib/print.c -m32

convert.o: lib/convert.c 
	gcc -Iinclude -nostdlib -fno-builtin  -Wall -c lib/convert.c -m32

clean:
	rm *.o *.bin *.iso

run:
	qemu-system-i386 -cdrom stalker.iso

#-s start port 1234, -S waiting for gdb
debug:
	qemu-system-i386 -s -S -kernel kernel.bin
