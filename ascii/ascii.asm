section .data
  str1        db      "1 + 2 + 3 +...+ 9 = ", 0
  sum         db      0
  ascii       db      "00", 10, 0

section .text
  global _start

_start:
next1:
  add byte[sum], cl
  inc cx
  cmp cx, 9
  jbe next1

  mov rcx, 1
  mov al, byte[sum]
next2:
  mov ah, 0
  mov bl, 10
  div bl
  add byte[ascii+rcx], ah
  dec rcx
  cmp rcx, 0
  jge next2

  ; cout << str1
  mov rax, 1
  mov rdi, 1
  mov rsi, str1
  mov rdx, 20
  syscall

  ; cout << ascii
  mov rax, 1
  mov rdi, 1
  mov rsi, ascii
  mov rdx, 3
  syscall

  ; exit program
  mov rax, 60
  mov rdi, 0
  syscall
