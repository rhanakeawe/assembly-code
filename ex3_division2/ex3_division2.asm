; ex3_division2.asm
; unsigned int num1 = 100000;
; unsigned short num2 = 333, quot = 0, remd = 0;
; quot = num1 / num2;
; remd = num1 % num2;

section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
num1		dd	100000			;num1 = 100000 = 0001 86A0h
num2		dw	333			;num2 = 333 = 014Dh
quot		dw	0			;quot = 0000h
remd		dw	0			;remd = 0000h

section .text
        global _start
_start:
        mov     ax, word[num1]			;ax = [num1+0] = 86A0h
	mov	dx, word[num1+2]		;dx = [num1+2] = 0001h
        div     word[num2]			;ax=dx:ax/[num2]=300,dx=dx:ax%[num2]=100 
        mov     word[quot], ax			;quot = ax = 300
        mov     word[remd], dx			;remd = dx = 100
_stop:
        mov     rax, SYS_exit			;terminate excuting process
        mov     rdi, EXIT_SUCCESS		;exit status
        syscall					;calling system services