; input.asm
; char msg1[] = "Input a number (1~9) : ";
; char msg2[] = "multiple of 3 include: ";
; char buffer;
; char num;
; char ascii[10];
;
; register int r10 = 0;
; do {
; cout << msg1;
; cin >> buffer;
; ascii[r10] = buffer;
; r10++;
; } while(r10 < 9);
; r10 = 0;
; do {
; num = atoi(ascii[r10]);
; if(num%3 == 0) {
; cout << ascii[r10] << msg2;
; }
; r10++;
; } while(r10 < 9);

section .data
  msg1 db "Input a number (1~9) : " ;input message
  msg2 db " is multiple of 3",10 ;output message
section .bss
  buffer resb 1 ;1-byte for buffer
  num resb 1 ;1-byte for num
  ascii resb 10 ;10-byte for ascii
section .text
  global _start
_start:
  mov r10, 0
inLoop:
  ; cout << mesg
  mov rax, 1 ;SYS_write
  mov rdi, 1 ;write to STD_OUT
  mov rsi, msg1 ;address of mesg
  mov rdx, 23 ;23 character to write
  syscall ;calling system services
  ; cin >> buffer
  mov rax, 0 ;SYS_read
  mov rdi, 1 ;read from STD_IN
  mov rsi, buffer ;address of the buffer
  mov rdx, 2 ;input length = 2
  syscall ;calling system services
  mov al, byte[buffer] ;al=[buffer] (ex: '5'=35h)
  mov byte[ascii+r10], al ;[num+r10] = al
  add r10, 1 ;r10 = r10 + 1
  cmp r10, 9 ;compare r10 with 9
  jne inLoop ;if(r10!=10) goto inLoop
  mov r10, 0
outLoop:
  ; if(num%3 != 0)
  mov al, byte[ascii+r10] ;al = [num+r10]
  and al, 0fh ;convert ascii to number
  mov ah, 0 ;ah = 0
  mov bl, 3 ;bl = 3
  div bl ;ah = ax%bl, al = ax/bl
  cmp ah, 0 ;compare ah wieh 0
  jne not_mul3 ;if(rem!=0) goto not_mul3
  ; else
  ; cout << ascii
  mov rax, 1 ;SYS_write
  mov rdi, 1 ;where to write
  lea rsi, [ascii+r10] ;address of ascii+r10
  mov rdx, 1 ;1 character to write
  syscall ;calling system services

  ; cout << msg2
  mov rax, 1 ;SYS_write
  mov rdi, 1 ;where to write
  mov rsi, msg2 ;address of buffer
  mov rdx, 18 ;18 character to write
  syscall ;calling system services
not_mul3:
  add r10, 1 ;r10 = r10 + 1
  cmp r10, 9 ;compare r10 with 10
  jne outLoop ;if(r10!=10) goto outloop
done:
  mov rax, 60 ;terminate excuting process
  mov rdi, 0 ;exit status
  syscall ;calling system services
