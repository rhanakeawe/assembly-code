; ex9_cinConvFunct.asm
; #begin define print(addr, n)
;	rax = 1;
;	rdi = 1;
;	rsi = addr of string;
;	rdx = n;
;	syscall;
; #end
; #begin define scan(addr, n)
;	rax = 1;
;	rdi = 1;
;	rsi = addr of buffer;
;	rdx = n;
;	syscall;
; #end
;
; void main() {
; 	char buffer[4];
; 	short n;
; 	short sumN;
; 	char ascii[10];
; 	char msg1[] = "Input a number (001~140): ";
; 	char msg2[] = "1 + 2 + 3 +...+ N = ";
;
; 	print(msg1, 26);
; 	scan(buffer, 4);
; 	call toInteger(n, buffer);
; 	call calculate(n, sumN);
; 	call toString(n, ascii);
; 	print(msg2, 20);
; 	print(ascii, 5);
; }
;
; void toInteger(n, buffer) {
;	n = atoi(buffer);
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
buffer		resb	4
n		resw	1
sumN		resw    1
ascii		resb    10

section .data
LF		equ	10
NULL		equ	0
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
msg1		db	"Input a number (001~140): "
msg2		db      "1 + 2 + 3 +...+ N = "

section .text
        global _start
_start:
	print	msg1, 26				;cout << msg1
	scan	buffer, 4				;cin >> buffer
	mov	rbx, buffer				;rbx = address of buffer
	call	toInteger

	; calculates 1+2+3+...+N
	mov	rcx, 0					;rcx = 0
	mov	di, word[n]				;di = n
	call 	calculate				;call calculate

	; converts sum100 into ascii
	mov	rcx, 3
	mov	di, word[sumN]				;di = sumN
	call	toString

	; display message and result
	print	msg2, 20				;cout << str1
	print	ascii, 5				;cout << ascii

        mov     rax, SYS_exit				;terminate excuting process
        mov     rdi, EXIT_SUCCESS			;exit status
        syscall						;calling system services

; ascii to number function
toInteger:
	mov	rax, 0					;clear rax
	mov	rdi, 10					;rdi = 10
	mov	rsi, 0					;counter = rsi = 0
next0:
	and	byte[rbx+rsi], 0fh			;convert ascii to number
	add	al, byte[rbx+rsi]			;al = number
	adc	ah, 0					;ah = 0
	cmp	rsi, 2					;compare rsi with 2
	je	skip0					;if rsi=2 goto skip0
	mul	di					;dx:ax = ax * di
skip0:
	inc	rsi					;rcx++
	cmp	rsi, 3					;compare rcx with 3
	jl	next0					;if rcx<3 goto next0
	mov	word[n], ax				;n = ax
	ret

; calculation function
calculate:
next1:
	add	word[sumN], cx				;sumN += cx
	inc	cx					;cx++
	cmp	cx, di					;compare ecx and di=100
	jbe	next1					;if(cx<=di) jump to next1
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
	mov 	byte [rbx+rdi], 10 			;string[rdi] = newline
	ret