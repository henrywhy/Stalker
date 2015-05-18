#create bootable iso image
stalker.iso: kernel.bin
	mkdir -p isodir/boot/grub
	cp kernel.bin isodir/boot/kernel.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o stalker.iso isodir
	rm -rf isodir

#create Stalker OS Kernel
kernel.bin: kernel.o boot.o link.lds
	ld kernel.o boot.o -T link.lds -o kernel.bin -m elf_i386

#generate boot obj
boot.o: boot.S
	gcc -I. -nostdlib -fno-builtin  -Wall -c boot.S -m32

#compile kernel
kernel.o: kernel.c
	gcc -I. -nostdlib -fno-builtin  -Wall -c kernel.c -m32

clean:
	rm *.o
