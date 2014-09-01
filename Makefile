#生成Stalker OS Kernel
kernel.bin: kernel.o boot.o link.ld
	ld kernel.o boot.o -T link.ld -o kernel.bin

#.S预处理汇编程序
boot.o: boot.S
	gcc -I. -nostdlib -fno-builtin  -Wall -c boot.S

#C语言函数的实现
kernel.o: kernel.c
	gcc -I. -nostdlib -fno-builtin  -Wall -c kernel.c

clean:
	rm *.o