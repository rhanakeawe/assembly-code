; ex4_if-else.asm
; unsigned char num1 = 200, num2 = 100;
; unsigned char max = 0, min = 0;
; if(num1 < num2) {
;    max = num2; min = num1;
; } else {
;    max = num1; min = num2;
; }

section .data
SYS_exit	equ	60
EXIT_SUCCESS	equ	0
num1		db	200			;num1 = C8h
num2		db	100			;num2 = 64h
max		db	0			;max = 00h
min		db	0			;min = 00h
    
section .text
        global _start
_start:
        mov     al, byte[num1]			;al = num1 = C8h
        mov     bl, byte[num2]			;ab = num1 = 64h
        cmp     al, bl				;al-bl = num1-num2
        jae     else_block			;if(num1>num2) goto else_block
if_block:
        mov     byte[max], bl			;max = bl
        mov     byte[min], al			;min = al
	jmp	end_if
else_block:
        mov     byte[max], al			;max = al = C8h
        mov     byte[min], bl			;min = bl = 64h
end_if:
        mov     rax, SYS_exit			;terminate excuting process
        mov     rdi, EXIT_SUCCESS		;exit status
        syscall					;calling system services