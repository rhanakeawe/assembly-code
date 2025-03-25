section .data
  year    dw    1000,1900,1980,2000,2010,2020,2024,2030,2040,2050

section .bss
  leap    resw  10

section .text
  global _start

_start:
  mov word[leap], 0
  mov rsi, 0
  mov rdi, 0
  mov rcx, 10
next:
  cmp rcx, 0
  je done
  mov ax, word[year+rsi]
  mov dx, 400
  div dx
  cmp dx, 0
  je isleap
  mov ax, word[year+rsi]
  mov dx, 4
  div dx
  cmp dx, 0
  jne after
  mov ax, word[year+rsi]
  mov dx, 100
  div dx
  cmp dx, 0
  je after
isleap:
  mov ax, word[year+rsi]
  mov word[leap+rdi], ax
  inc rdi
after:
  inc rsi
  dec rcx
  jmp next
done:
  mov rax, 60
  mov rdi, 0
  syscall
