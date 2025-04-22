; ex9_coutConvFunct.asm
; #begin define print(addr, n)
;	mov	rax, 1
;	mov	rdi, 1
;	mov	rsi, addr
;	mov	rdx, n
;	syscall
; #end
;
; void main() {
; 	short sumN;
; 	char ascii[10];
; 	const char N = 99;
; 	char str1[] = "1 + 2 + 3 +...+ N = ";
;
; 	call calculate(N, sumN);
; 	call toString(N, ascii);
; 	print(str1, 20);
; 	print(ascii, 5);
; }
; 
; void calculate(N, sumN) {
;	for(cx=0; cx<=N; cx++) {
;		sumN += cx;
;	}
; }
;
; void toString(N, ascii) {
; 	ascii = itoa(sumN);
; }

%macro	print 	2
        mov     rax, 1					;SYS_write
        mov     rdi, 1					;where to write
        mov     rsi, %1					;address of strint
        mov     rdx, %2					;number of character
        syscall						;calling system services
%endmacro

section .bss
sumN		resw    1
ascii		resb    10

section .data
LF		equ	10
NULL		equ	0
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
N		equ	99
str1		db      "1 + 2 + 3 +...+ N = ", NULL

section .text
        global _start
_start:
	; calculates 1+2+3+...+N
	mov	di, N					;di = N = 100
	call 	calculate				;call calculate

	; converts sum100 into ascii
	mov	di, word[sumN]				;di = sumN
	call	toString

	; display message and result
	print	str1, 20				;cout << str1
	print	ascii, 5				;cout << ascii

        mov     rax, SYS_exit				;terminate excuting process
        mov     rdi, EXIT_SUCCESS			;exit status
        syscall						;calling system services

; calculation function
calculate:
	mov	rcx, 0					;rcx = 0
next1:
	add	word[sumN], cx				;sumN += cx
	inc	cx					;cx++
	cmp	cx, di					;compare cx and di=100
	jbe	next1					;if(cx<=100) jump to next1
	ret

; converts sumN into ascii
toString:
	; Part A - Successive division
	mov 	ax, word[sumN] 				;get integer
	mov 	rcx, 0 					;digitCount = 0
	mov 	bx, 10 					;set for dividing by 10
divideLoop:
	mov 	dx, 0
	div 	bx 					;divide number by 10
	push 	rdx 					;push remainder
	inc 	rcx 					;increment digitCount
	cmp 	ax, 0 					;if (result > 0)
	jne 	divideLoop 				;goto divideLoop

	; Part B - Convert remainders and store
	mov 	rbx, ascii 				;get addr of ascii
	mov 	rdi, 0 					;rdi = 0
popLoop:
	pop 	rax 					;pop intDigit
	add 	al, "0" 				;al = al + 0x30
	mov 	byte [rbx+rdi], al 			;string[rdi] = al
	inc 	rdi 					;increment rdi
	loop 	popLoop 				;if (digitCount > 0) goto popLoop
	mov 	byte [rbx+rdi], LF 			;string[rdi] = newline
	ret