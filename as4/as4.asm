; multiple.asm
; unsigned short num = 65535;
; unsigned short mul_3 = 0, other = 0;
; if(num % 3 == 0 && num % 5 != 0) {
; mul_3++;
; } else {
; other++;
; }
section .data
  num dw 65535
  mul_3 dw 0 ;mul_3 = 0
  other dw 0 ;other = 0
section .text
  global _start
_start:
  mov ax, word[num] ;ax = num
  mov dx, 0 ;dx = 0
  mov bx, 3 ;bx = 3
  div bx ;dx = dx:ax%bx, ax = dx:ax/bx
  cmp dx, 0 ;compare dx,0
  jne else ;if(ax%3!=0) goto else
  mov ax, word[num] ;ax = num
  mov dx, 0 ;dx = 0
  mov bx, 5 ;bx = 5
  div bx ;dx = dx:ax%bx, ax = dx:ax/bx
  cmp dx, 0 ;compare dx,0
  je else ;if(ax%5!=0) goto else
  inc word[mul_3] ;mul_3 = mul_3 + 1
  jmp end_if ;goto end_if
else:
  inc word[other] ;other = other + 1
end_if:
  mov rax, 60 ;terminate executing process
  mov rdi, 0 ;exit status
  syscall ;calling system services
