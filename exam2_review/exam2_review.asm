;quiz02.asm
;char num[10] = {-12,23,34,45,-56,67,-78,89,90,0};	//8-bit numeric array
;short posTotal;					//16-bit non-initial variable
;short negTotal;					//16-bit non-initial variable
;register long rcx = 0					//64-bit register
;while (num[rcx] != 0) {
;	if(num[rcx] > 0) {
;		posTotal = posTotal + short(num[rcx]);	//posTotal = 348
;	} else {
;		negTotal = negTotal + short(num[rcx]);	//negTotal = -146
;	}
;	rcx++;
;}

section .data
        num      db      -12,23,34,45,-56,67,-78,89,90,0

section .bss
        posTotal resw    1
        negTotal resw    1

section .text
        global _start
_start:
	mov	word[posTotal], 0
	mov	word[negTotal], 0
	mov	rcx, 0
next:
	cmp	byte[num+rcx], 0
	je	done
	jg	positive
	mov	al, byte[num+rcx]
	cbw					;movsx   ax, al
	add	word[negTotal], ax
	inc	rcx
	jmp	next
positive:
	mov	al, byte[num+rcx]
	cbw					;movsx   ax, al
	add	word[posTotal], ax
	inc	rcx
	jmp	next
done:
	mov     rax, 60				;terminate excuting process
	mov     rdi, 0				;exit status
	syscall					;calling system services