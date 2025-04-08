;multiplication.asm
;unsigned int num1 = 300,000;
;unsigned int num2 = 400,000;
;unsigned long product = 0;
;product = long(num1 * num2);

section .data
  num1 dd 300000 ;num1 = 0004 93E0h
  num2 dd 400000 ;num2 = 0006 1A80h
  product dq 0 ;product = 0000 0000 0000 0000h
section .text
  global _start
_start:
  mov eax, dword[num1] ;eax = num1 = 0004 93E0h
  mul dword[num2] ;edx:eax = eax * num2 = 0000 001B F08E B000h
  mov dword[product], eax ;product+0 = eax = F08E B000h
  mov dword[product+4], edx ;product+8 = eax = 0000 001Bh
  mov rax, 60 ;terminate excuting process
  mov rdi, 0 ;exit status
  syscall
