section .data
  NULL          equ   0
  EXIT_SUCCESS  equ   0
  SYS_exit      equ   60
  intNum        dd    1498

section .bss
  strNum    resb  10

section .text
  global    _start

_start:
  mov   eax, dword[intNum]    ; get integer
  mov   rcx, 0                ; digitCount = 0
  mov   ebx, 10               ; set for dividing by 10
divideLoop:
  mov   edx, 0
  div   ebx                   ; divide number by 10
  push  rdx                   ; push remaineder
  inc   rcx                   ; increment digitCount
  cmp   eax, 0                ; if (result > 0)
  jne   divideLoop            ; goto divideLoop
  mov   rbx, strNum           ; get addr of string
  mov   rdi, 0                ; idx = 0
popLoop:
  pop   rax                   ; pop intDigit
  add   al, "0"               ; char = int + "0"
  mov   byte[rbx+rdi], al     ; string[idx] = char
  inc   rdi                   ; increment idx
  loop  popLoop               ; if (digitCount > 0)
  mov   byte[rbx+rdi], NULL   ; string[idx] = NULL
last:
  mov   rax, SYS_exit
  mov   rdi, EXIT_SUCCESS
  syscall
