; ex8_cinMacro.asm
; #begin define print(string, n)
;	rax = 1;
;	rdi = 1;
;	rsi = &string;
;	rdx = n;
;	syscall;
; #end
; #begin define scan(buffer, n)
;	rax = 0;
;	rdi = 0;
;	rsi = &buffer;
;	rdx = n;
;	syscall;
; #end
; char buffer[4];
; short n;
; short sumN;
; char ascii[10];
; char msg1[] = "Input a number (100~140): ";
; char msg2[] = "1 + 2 + 3 +...+ N = ";
;
; print(msg1, 26);
; scan(buffer, 4);
; n = atoi(buffer);
; rcx = 0;
; do {
;   sumN += rcx;
; } while(rcx <= n);
; ascii = itoa(sumN);
; print(msg2, 20);
; print(ascii, 5);

%macro	print 	2
        mov     rax, 1					;SYS_write
        mov     rdi, 1					;standard output device
        mov     rsi, %1					;output string address
        mov     rdx, %2					;number of character
        syscall						;calling system services
%endmacro

%macro	scan 	2
        mov     rax, 0					;SYS_read
        mov     rdi, 0					;standard input device
        mov     rsi, %1					;input buffer address
        mov     rdx, %2					;number of character
        syscall						;calling system services
%endmacro

section .bss
buffer	resb	4
n	resw	1
sumN	resw    1
ascii	resb    10

section .data
LF		equ	10
NULL		equ	0
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
msg1	db	"Input a number (100~140): ", NULL
msg2	db      "1 + 2 + 3 +...+ N = ", NULL

section .text
        global _start
_start:
	print	msg1, 26				;cout << msg1
	scan	buffer, 4				;cin >> buffer
	mov	ax, 0					;clear ax
	mov	bx, 10					;bx = 10
	mov	rsi, 0					;counter = 0
inputLoop:
	and	byte[buffer+rsi], 0fh			;convert ascii to number
	add	al, byte[buffer+rsi]			;al = number
	adc	ah, 0					;ah = 0
	cmp	rsi, 2					;compare rcx with 2
	je	skipMul					;if rcx=2 goto skipMul
	mul	bx					;dx:ax = ax * bx
skipMul:
	inc	rsi					;rcx++
	cmp	rsi, 3					;compare rcx with 3
	jl	inputLoop				;if rcx<3 goto inputLoop
	mov	word[n], ax				;n = ax

	; calculates 1+2+3+...+N
	mov	cx, 0					;cx = 0
sumLoop:
	add	word[sumN], cx				;sumN += cx
	inc	cx					;cx++
	cmp	cx, word[n]				;compare cx with n
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

	print	msg2, 20				;cout << msg2
	print	ascii, 5				;cout << ascii

  mov     rax, SYS_exit				;terminate excuting process
  mov     rdi, EXIT_SUCCESS			;exit status
  syscall						;calling system services
