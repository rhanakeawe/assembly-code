; ex7_cinNum.asm
; char num;
; char buffer;
; char mesg[] = "Input a number (0~9): ";
; char even[] = " is an even number\n";
; char odd[] = " is an odd number\n";
;
; cout << msg;
; cin >> num;
; if(num%2 == 0)
;   cout << num << " is an even number\n";
; else
;   cout << num << " is an odd number\n";

section .bss
num		resb    1			;reserve 1-byte for num
buffer		resb	1			;reserve 1-byte for buffer

section .data
LF		equ	10
NULL		equ	0
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
mesg		db	"Input a number (0~9): "	;input message
even		db	" is an even number", 10	;even message
odd		db	" is an odd number", 10		;odd message

section .text
        global _start
_start:
	; cout << mesg
        mov     rax, 1				;SYS_write
        mov     rdi, 1				;write to STD_OUT
        mov     rsi, mesg			;address of mesg
        mov     rdx, 22				;22 character to write
        syscall					;calling system services

	; cin >> num
	mov	rax, 0				;SYS_read
	mov	rdi, 0				;read from STD_IN
	mov	rsi, buffer			;address of the buffer
	mov	rdx, 1				;input length = 1
	syscall					;calling system services
	mov	al, byte[buffer]		;al = buffer (ex: '5'=35h)
	and	al, 0fh				;al = block bit7~4 (ex: 05h)
	mov	byte[num], al			;num = al (ex: num=05h)

	; if(num%2 == 0)
        mov     ah,0				;ah=0
        mov     al, byte[num]			;al=num
        mov     bl, 2				;bl=2
        div     bl				;ah=ax%bl, al=ax/bl
        cmp     ah, 0				;compare ah,0
        jnz     odd_num 			;if(rem!=0) goto odd_num
	; cout << num
        mov     rax, 1				;SYS_write
        mov     rdi, 1				;where to write
        mov     rsi, buffer			;address of buffer
        mov     rdx, 1				;1 character to write
        syscall					;calling system services
	; cout << even
        mov     rax, 1				;SYS_write
        mov     rdi, 1				;where to write
        mov     rsi, even			;address of num
        mov     rdx, 19				;18 character to write
        syscall					;calling system services
	jmp	done				;jump to done
	; else
odd_num:
	; cout << num
        mov     rax, 1				;SYS_write
        mov     rdi, 1				;where to write
        mov     rsi, buffer			;address of buffer
        mov     rdx, 1				;1 character to write
        syscall					;calling system services
	; cout << odd
        mov     rax, 1				;SYS_write
        mov     rdi, 1				;where to write
        mov     rsi, odd			;address of odd
        mov     rdx, 18				;17 character to write
        syscall					;calling system services
done:
        mov     rax, SYS_exit			;terminate excuting process
        mov     rdi, EXIT_SUCCESS		;exit status
        syscall					;calling system services