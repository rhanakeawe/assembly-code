section .data
  NULL            equ   0
  EXIT_SUCCESS    equ   0
  SYS_exit        equ   60
  strNum          db    "1498"

section .bss
  intNum    resw  1

section .text
  global    _start

_start:
  mov   rax, 0                ; clear rax
  mov   rdi, 10               ; rdi = 10
  mov   rbx, strNum           ; rbx = address of strNum
  mov   rsi, 0                ; counter = rsi = 0
next:
  and   byte[rbx+rsi], 0fh    ; convert strNum to number
  add   al, byte[rbx+rsi]     ; al = number
  adc   ah, 0                 ; ah = 0
  cmp   rsi, 3                ; compare rsi with 3
  je    skip                  ; if rsi = 3 goto skip
  mul   di                    ; dx:ax = ax * di
skip:
  inc   rsi                   ; rsi++
  cmp   rsi, 4                ; compare rsi with 4
  jl    next                  ; if rsi<4 goto next
  mov   word[intNum], ax      ; intNum = ax
last:
  mov   rax, SYS_exit
  mov   rdi, EXIT_SUCCESS
  syscall
