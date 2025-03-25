;exam01_review.asm
;signed char num1 = 50;				//8-bit signed vairable
;signed char num2 = -30;			//8-bit signed vairable
;signed char num3 = -23;			//8-bit signed vairable
;signed short product = 0			//16-bit signed vairable
;signed char quotient = 0;			//8-bit signed vairable
;signed char remainder = 0;			//8-bit signed vairable
;product = num1 * num2;
;quotient = product / num3;
;remainder = product % num3;

section .data
        num1      db      50			;num1 = 0x32
        num2      db      -30			;num2 = 0xE2
        num3      db      -23			;num3 = 0xE9
	product   dw      0			;product = 0x0000
	quotient  db      0			;quotient = 0x00
	remainder db      0			;remainder = 0x00

section .text
        global _start
_start:
	mov	al, byte[num1]			;al = num1 = 0x32
	imul	byte[num2]			;ax = al*num2 = 0x32*0xE2 = 0xFA24
	mov	word[product], ax		;product = ax = 0xFA24 = -1500
	idiv	byte[num3]			;ah=ax%num3=0xFB, al=ax/num3=0x41
	mov     byte[quotient], al		;quotient = al = 0x41 = 65
	mov     byte[remainder], ah		;remainder = ah = 0xFB = -5

	mov     rax, 60				;terminate excuting process
	mov     rdi, 0				;exit status
	syscall					;calling system services