extern isrc
global _start
[section .text]
[bits 32]
_start:
	cli
	call isrc
	in al, 0x60
	mov al, 0x20
	out 0x20, al		;告诉8259A EOI，即当前中断处理结束，以便接受下一个中断信号
	sti
	iret
