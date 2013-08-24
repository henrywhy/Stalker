;--------------------------------------------------
;kernel内存地址0x00040000,即在代码段中起始部分
;--------------------------------------------------
SelectorVGAText equ 0x0010		;VGA文本模式视频数据段的选择子
SelectorVGAGraphic equ 0x0020		;VGA图形模式视频数据段的选择子
SelectorStack equ 0x0018		;0x1000000到0x1fffff之间1M的堆栈段的选择子

;extern LoopForever				;C语言函数void LoopForever()
extern StalkerMain				;C语言函数void PaintScreen()


global _start			;汇编函数
;global memcpy			;汇编函数供C语言调用

[section .text]

[bits 32]	
_start:
	;;初始化数据段，指向VGA文本模式视频缓冲区
	; mov ax, SelectorVGAText
	; mov ds, ax
	
	;;初始化堆栈段，指向扩展空间的1k的堆栈段
	; mov ax, SelectorStack
	; mov ss, ax
	; mov esp, 0x600		;1k的堆栈
	; mov ebp, 0x600
	
	;;清屏
	; call ClearScreen
	
	;;设置光标位置
	; mov bx, 0x0000		;0行0列
	; call SetCursor
	
	;;获取光标的位置
	; call GetCursor		;返回值在bx中

	
	;;计算光标位置相对于0xb8000处的偏移地址
	; mov ax, bx
	; shr ax, 8
	; mov cx, 160
	; mul cx
	; and bx, 0x00ff
	; shl bx, 1
	; add ax, bx
	; mov bx, ax
	; and ebx, 0x0000ffff
	
	;;开始显示信息
	; xor cl, cl			;字符显示计数器
	
	; mov byte [ebx], 'P'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], 'r'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], 'o'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], 't'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], 'e'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], 'c'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], 't'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], ' '
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], 'M'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], 'o'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], 'd'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], 'e'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov byte [ebx], '!'
	; add ebx, 1
	; mov byte [ebx], 0x0C
	; add ebx, 1
	; inc cl
	
	; mov bh, 0
	; mov bl, cl
	; call SetCursor
	

;------------------------------------------------------------------
;函数名：ClearScreen, VGA文本模式缓冲区清空,此时ds默认为VGA数据段
;------------------------------------------------------------------
; ClearScreen:
	; push ebp
	; mov ebp, esp
	; push ebx
	; xor ebx, ebx

; Label_Clear_Buffer:	
	; mov byte [ebx], ' '
	; inc ebx
	; mov byte [ebx], 0x07
	; inc ebx
	; cmp ebx, 2000*2 
	; jne Label_Clear_Buffer
	
	; pop ebx
	; pop ebp
	; ret
;--------------------------------------------------------------



;---------------------------------------------------------------
;函数名：SetCursor，VGA文本模式下设置光标的位置，传递参数为bx
;bh为行号，bl为列号
;---------------------------------------------------------------
; SetCursor:
	; push ebp	
	; mov ebp, esp
	; mov dx, 0x03d4		;dx存放端口地址
	; mov al, 0x0e		;al存放传送的数据
	; out dx, al
	; mov dx, 0x03d5
	; mov al, bh
	; out dx, al			;设置行号
	
	; mov dx, 0x03d4		;dx存放端口地址
	; mov al, 0x0f		;al存放传送的数据
	; out dx, al
	; mov dx, 0x03d5
	; mov al, bl
	; out dx, al			;设置列号
	; pop ebp
	; ret
;---------------------------------------------------------------

	
;----------------------------------------------------------------
;函数名：GetCursor，获取光标位置，返回值在bx中，bh行，bl列
;----------------------------------------------------------------
; GetCursor:	
	; push ebp
	; mov ebp, esp
	; mov dx, 0x03d4		;dx存放端口地址
	; mov al, 0x0e		;al存放传送的数据
	; out dx, al
	; mov dx, 0x03d5
	; in al, dx		
	; mov bh, al		;光标高8位
	
	; mov dx, 0x03d4
	; mov al, 0x0f
	; out dx, al
	; mov dx, 0x03d5
	; in al, dx		
	; mov bl, al		;光标低8位
	; pop ebp
	; ret
;----------------------------------------------------------------	
	
	
	
	;切换数据段地址，指向VGA图形模式的视频缓冲区
	mov ax, SelectorVGAGraphic
	mov ds, ax
	
	;;初始化堆栈段，指向扩展空间的1k的堆栈段
	mov ax, SelectorStack
	mov ss, ax
	mov esp, 0x600		;1k的堆栈
	mov ebp, 0x600
	
	call StalkerMain
	
	jmp $
	
;;----------------------------------------------------------------
;;函数名：void memcpy(int address, int color) 向指定地址的内存空间赋值
;;----------------------------------------------------------------
; memcpy:
	; push ebp
	; mov ebp, esp
	; push ebx
	; mov ebx, [ebp+8]
	; mov eax, [ebp+12]
	; mov [ebx], al			;1个字节地拷贝
	; pop ebx
	; pop ebp
	; ret
;;----------------------------------------------------------------	
	
	
	
	
	
	
	