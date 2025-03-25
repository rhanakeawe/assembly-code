; ex_arrayMax.asm
; unsigned short array[7] = {12, 10000, 6543, 20000, 789, 30000, 9876};
; unsigned short max;
; register long rsi = 0;
; do {
;    if(array[i] > max)
;	max = array[rsi];
;    rsi++;
; } while(rsi < 7);

section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
array		dw	12, 10000, 6543, 20000, 789, 30000, 9876

section .bss
max		resw	1			;reserve 1 word space

section .text
        global _start
_start:
	mov	rsi, 0				;rsi = 0
doloop:
	mov	ax, word[array+(rsi*2)]		;ax = array[rsi]
	cmp	ax, word[max]			;compare ax and max
	jbe	not_max				;if(ax>max) {
	mov	word[max], ax			;    max = ax = array[rsi]
not_max:					;{
        inc     rsi				;rsi = rsi + 1
        cmp	rsi, 7				;compare rsi and 7
	jb	doloop				;if(rsi<7) goto doloop

        mov     rax, SYS_exit			;terminate excuting process
        mov     rdi, EXIT_SUCCESS		;exit status
        syscall					;calling system services