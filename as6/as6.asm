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
