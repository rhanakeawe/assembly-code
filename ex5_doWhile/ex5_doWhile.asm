;ex_doWhile.asm
;char cx = 1;
;char sum = 0;
;do {
;	sum = sum + cx;
;	cx++;
;} while(cx <= 10);

section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
sum		dw	0

section .text
        global _start
_start:
	mov	cx, 1				;cx = 1
doloop:
        add     word[sum], cx			;sum = sum + cx
        inc     cx				;cx = cx
        cmp     cx, 10				;compare cx and 10
        jbe     doloop				;if(cx<=10) jump to doloop

        mov     rax, SYS_exit			;terminate excuting process
        mov     rdi, EXIT_SUCCESS		;exit status
        syscall					;calling system services