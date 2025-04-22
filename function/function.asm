;#begin define print(addr, n)
;	rax = 1;
;	rdi = 1;
;	rsi = addr of string;
;	rdx = n;
;	syscall;
;#end
;#begin define scan(addr, n)
;	rax = 1;
;	rdi = 1;
;	rsi = addr of buffer;
;	rdx = n;
;	syscall;
;#end
;int main() {
;	char buffer[4];
;	int n;
;	int sumN;
;	char ascii[10];
;	char msg1[26] = "Input a number (004~999): ";
;	char msg2[16] = "1 + 2 + 3 +...+ ";
;	char msg3[4] = " = ";
;
;	print(msg1, 26);
;	scan(buffer, 4);
;	call toInteger(n, buffer);
;	call calculate(n, sumN);
;	call toString(n, ascii);
;	print(msg2, 16);
;	print(buffer, 3);
;	print(msg3, 3);
;	print(ascii, 6);
;	return 0;
;}
;void toInteger(n, buffer) {
;	n = atoi(buffer);
;}
;void calculate(n, sumN) {
;	for(ecx=0; ecx<=n; ecx++) {
;		sumN += ecx;
;	}
;}
;void toString(sumN, ascii) {
;	ascii = itoa(sumN);
;}

%macro	print 	2
  mov     rax, 1
  mov     rdi, 1
  mov     rsi, %1
  mov     rdx, %2
  syscall
%endmacro

%macro	scan 	2
  mov     rax, 0
  mov     rdi, 0
  mov     rsi, %1
  mov     rdx, %2
  syscall
%endmacro

section .bss
  buffer      resb  4
  n           resd  1
  sumN        resd  1
  ascii       resb  10

section .data
  LF            equ   10
  NULL          equ   0
  SYS_exit      equ   60
  EXIT_SUCCESS  equ   0
  msg1          db    "Input a number (004~999): "
  msg2          db    "1 + 2 + 3 +...+ "
  msg3          db    " = "

section .text
  global _start

_start:
  print   msg1, 26
  scan    buffer, 4
  
  mov     rbx, buffer
  call    toInteger

  mov     rcx, 0
  mov     edi, dword[n]
  call    calculate

  mov     rcx, 3
  mov     edi, dword[sumN]
  call    toString

  print   msg2, 16
  print   buffer, 3
  print   msg3, 3
  print   ascii, 6

  mov     rax, SYS_exit
  mov     rdi, EXIT_SUCCESS
  syscall

toInteger:
  mov     eax, 0
  mov     bx, 10
  mov     rsi, 0
next0:
  mov     bl, 0
  mov     bl, byte[buffer+rsi]
  and     bl, 0fh
  add     al, bl
  adc     ah, 0
  cmp     rsi, 2
  je      skip0
  mov     bx, 10
  mul     bx
skip0:
  inc     rsi
  cmp     rsi, 3
  jl      next0
  mov     dword[n], eax
  ret

calculate:
next1:
  add     dword[sumN], ecx
  inc     ecx
  cmp     ecx, edi
  jbe     next1
  ret

toString:
  mov     eax, dword[sumN]
  mov     rcx, 0
  mov     ebx, 10
divideLoop:
  mov     dx, 0
  div     ebx
  push    rdx
  inc     rcx
  cmp     eax, 0
  jne     divideLoop
  mov     rbx, ascii
  mov     rdi, 0
popLoop:
  pop     rax
  add     al, "0"
  mov     byte[rbx+rdi], al
  inc     rdi
  loop    popLoop
  mov     byte[rbx+rdi], LF
  ret
