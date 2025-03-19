section .data
  SYS_exit        equ   60
  EXIT_SUCCESS    equ   0
  num1            db    100
  num2            db    200
  sum             dw    0

section .text
                  global _start

_start:
  mov             al, byte[num1]
  add             al, byte[num2]
  adc             ah, 0
  mov             byte[sum+0], al
  mov             byte[sum+1], ah
  mov             rax, SYS_exit
  mov             rdi, EXIT_SUCCESS
  syscall
