#生成Stalker OS Kernel
kernel.bin: kernel.o boot.o link.lds
	ld kernel.o boot.o -T link.lds -o kernel.bin -m elf_i386

#.S预处理汇编程序
boot.o: boot.S
	gcc -I. -nostdlib -fno-builtin  -Wall -c boot.S -m32

#C语言函数的实现
kernel.o: kernel.c
	gcc -I. -nostdlib -fno-builtin  -Wall -c kernel.c -m32

clean:
	rm *.o
