CFLAGS=-Iinclude -nostdlib -fno-builtin -Wall -m32
QEMU=qemu-system-i386

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
	gcc -c boot/boot.S $(CFLAGS)

#compile kernel
kernel.o: kernel/kernel.c
	gcc -c kernel/kernel.c $(CFLAGS)

#standard library about some print functions
print.o: lib/print.c
	gcc -c lib/print.c $(CFLAGS)

convert.o: lib/convert.c 
	gcc -c lib/convert.c $(CFLAGS)

clean:
	rm *.o *.bin *.iso

run:
	$(QEMU) -cdrom stalker.iso

#-s start port 1234, -S waiting for gdb
debug:
	$(QEMU) -s -S -kernel kernel.bin
