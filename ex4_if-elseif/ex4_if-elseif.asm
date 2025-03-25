; ex4_if-elseif-else.asm
; unsigned char num1 = 200, num2 = 100;
; unsigned char greater = 0, less = 0, equal = 0;
; if(num1 > num2) {
;    greater++;
; } else if(num1 < num2){
;    less++;
; } else {
;    equal++;
; }

section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
num1		db	200			;num1 = C8h
num2		db	100			;num2 = 64h
greater		db	0                       ;greater = 00h
less		db	0			;less = 00h
equal		db	0			;equal = 00h
    
section .text
        global _start
_start:
        mov     al, byte[num1]			;al = num1 = C8h
        mov     bl, byte[num2]			;ab = num1 = 64h
        cmp     al, bl				;al-bl to change flag 
        ja      if_block			;if(num1>num2) goto if_block
	jb	else_if				;if(num1<num2) goto else_if
	jmp 	else
if_block:
        inc	byte[greater]			;greater++
	jmp	end_if				;goto end_if
else_if:
	inc	byte[less]			;less++
	jmp	end_if				;goto end_if
else:
	inc	byte[equal]			;equal++
end_if:
        mov     rax, SYS_exit			;terminate excuting process
        mov     rdi, EXIT_SUCCESS		;exit status
        syscall					;calling system services