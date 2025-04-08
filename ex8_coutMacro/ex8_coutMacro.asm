; ex8_coutMacro.asm
; #begin define print(addr, n)
;	mov	rax, 1
;	mov	rdi, 1
;	mov	rsi, addr
;	mov	rdx, n
;	syscall
; #end
; short sumN;
; char ascii[10];
; const char N = 99;
; char str1[] = "1 + 2 + 3 +...+ N = ";
;
; rcx = 0;
; do {
;   sumN += rcx;
; } while(rcx >= 0);
; ascii = itoa(sumN);
; print(str1, 20);
; print(ascii, 5);

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
	mov	cx, 0					;cx = 0
sumLoop:
	add	word[sumN], cx				;sumN += cx
	inc	cx					;cx++
	cmp	cx, N					;compare cx with N
	jbe	sumLoop					;if(cx<=100) goto sumLoop

	; converts sumN into ascii
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

	print	str1, 20				;cout << str1
	print	ascii, 5				;cout << ascii

  mov     rax, SYS_exit				;terminate excuting process
  mov     rdi, EXIT_SUCCESS			;exit status
  syscall						;calling system services
