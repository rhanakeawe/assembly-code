section .data
  LF            equ   10
  NULL          equ   0
  SYS_exit      equ   60
  EXIT_SUCCESS  equ   0
  str1          db    "1+2+3+...+99="
  sum           dw    0
  ascii         db    "0000", LF, NULL

section .text
  global _start

_start:
next1:
  add word[sum], cx
  inc ecx
  cmp ecx, 99
  jbe next1

  mov ax, word[sum]
  mov rcx, 3
next2:
  mov bx, 10
  mov dx, 0
  div bx
  add byte[ascii+rcx], dl
  dec rcx
  cmp rcx, 0
  jge next2

  ; cout << str1
  mov rax, 1
  mov rdi, 1
  mov rsi, str1
  mov rdx, 13
  syscall

  ; cout << ascii
  mov rax, 1
  mov rdi, 1
  mov rsi, ascii
  mov rdx, 5
  syscall

  ; exit program
  mov rax, SYS_exit
  mov rdi, EXIT_SUCCESS
  syscall
