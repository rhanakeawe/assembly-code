;parity.asm
;unsigned short array[7] = {12, 1003, 6543, 24680, 789, 30123, 32766};
;unsigned short even[7];
;register long rsi = 0, rdi = 0;
;do {
; if(array[rsi] % 2 == 0) {
; even[rdi] = array[rsi];
; rdi++;
; }
; rsi++;
;} while(rsi < 7);
section .data
  array dw 12, 1325, 6543, 24680, 789, 30123, 32766
section .bss
  even resw 7
section .text
  global _start
_start:
  mov rsi, 0 ;rsi = 0
  mov rdi, 0 ;rdi = 0
  mov bx, 2 ;bx = 2
doloop:
  mov ax, word[array+(rsi*2)] ;ax = array[rsi]
  cwd ;convert ax to dx:ax
  div bx ;dx = dx:ax % bx
  cmp dx, 0 ;compare dx and 0
  jne not_even ;if(remainder==0) {
  mov r8w, word[array+(rsi*2)] ; r8w = array[rsi]
  mov word[even+(rdi*2)], r8w ; even[rdi] = r8w
  inc rdi ;rdi = rdi + 1
not_even: ;{
  inc rsi ;rsi = rsi + 1
  cmp rsi, 7 ;compare rsi and 7
  jb doloop ;if(rsi<7) goto doloop
  mov rax, 60 ;terminate excuting process
  mov rdi, 0 ;exit status
  syscall
