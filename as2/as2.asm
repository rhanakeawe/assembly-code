; addition.asm
; unsigned short num1 = 65244;
; unsigned short num2 = 4660;
; unsigned int sum = 0;
; sum = int(num1 + num2);

section .data
  num1 dw 65244 ;num1 = 0xFEDC
  num2 dw 4660 ;num2 = 0x1234
  sum dd 0 ;sum = 0
section .text
  global _start
_start:
  mov dx, 0 ;dx = 0
  mov ax, word[num1] ;ax = num1
  add ax, word[num2] ;ax = ax + num2
  adc dx, 0 ;dx = dx + 0 + CF
  mov word[sum+0], ax ;sum+0 = ax
  mov word[sum+2], dx ;sum+2 = dx
  ;sum = dx:ax
  mov rax, 60 ;terminate excuting process
  mov rdi, 0 ;exit status
  syscall
