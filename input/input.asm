section .data
  LF              equ     10
  NULL            equ     0
  SYS_exit        equ     60
  EXIT_SUCCESS    equ     0
  msg1            db      "Input a number (1~9): ", NULL
  msg2            db      " is Multiple of 3.", LF, NULL
  ascii           db      "00", 10

section .bss
  buffer    resb    1
  num       resb    1

section .text
  global    _start

_start:
  mov   r10, 0

doloop1:
  ;cout << msg1
  mov   rax, 1
  mov   rdi, 1
  mov   rsi, msg1
  mov   rdx, 22
  syscall

  ;cin >> buffer
  mov   rax, 0
  mov   rdi, 0
  mov   rsi, buffer
  mov   rdx, 2
  syscall

  ;ascii[r10] = buffer
  mov   al, byte[buffer]
  mov   byte[ascii+r10], al

  ;r10++
  inc   r10

  ;while(r10<9)
  cmp   r10, 9
  jb    doloop1

  ;r10=0
  mov   r10, 0

doloop2:
  ;num = atoi(ascii[r10])
  mov   al, byte[ascii+r10]
  add   al, 0fh
  mov   byte[num], al

  ;if(num%3==0)
  mov   bl, 3
  mov   ah, 0
  div   bl
  cmp   ah, 0
  jne   not_div

is_div:
  ;cout << ascii[r10]
  mov   rax, 1
  mov   rdi, 1
  mov   rsi, ascii
  add   rsi, r10
  mov   rdx, 1
  syscall

;cout << msg2
  mov   rax, 1
  mov   rdi, 1
  mov   rsi, msg2
  mov   rdx, 19
  syscall

not_div:
  ;r10++
  inc   r10

  ;while(r10<9)
  cmp   r10, 9
  jb    doloop2

  mov   rax, SYS_exit
  mov   rdi, EXIT_SUCCESS
  syscall
