;#begin define print(string, numOfChar)
;	rax = 1;
;	rdi = 1;
;	rsi = &string;
;	rdx = numOfChar;
;	syscall;
;#end
;#begin define scan(buffer, numOfChar)
;	rax = 0;
;	rdi = 0;
;	rsi = &buffer;
;	rdx = numOfChar;
;	syscall;
;#end
;int main(void) {
;	char buffer[4];
;	int n;
;	int sumN;
;	char msg1[26] = "Input a number (004~999): ";
;	char msg2[16] = "1 + 2 + 3 +...+ ";
;	char msg3[4] = " = ";
;	char ascii[10];
;	
;	print(msg1, 26);
;	scan(buffer, 4);
;	n = atoi(buffer);
;	rsi = 0;
;	do {
;	    sumN += rsi;
;	} while(rsi >= 0);
;	ascii = itoa(sumN);
;	print(msg2, 16);
;	print(buffer, 3);
;	print(msg3, 3);
;	print(ascii, 7);
;	return 0;
;}

%macro print 2
  mov   rax, 1
  mov   rdi, 1
  mov   rsi, %1
  mov   rdx, %2
  syscall
%endmacro

%macro scan 2
  mov   rax, 0
  mov   rdi, 0
  mov   rsi, %1
  mov   rdx, %2
%endmacro

section .bss
  buffer  resb  4
  n       resw  1
  sumN    resw  1
  ascii   resb  10

section .data
  LF              equ   10
  NULL            equ   0
  SYS_exit        equ   60
  EXIT_SUCCESS    equ   0
  msg1            db    "Input a number (004~999): ", NULL
  msg2            db    "1 + 2 + 3 +...+ "
  msg3            db    " = "

section .text
  global _start

_start:
  ;print(msg1,26)
  print msg1, 26

done:
  mov   rax, SYS_exit
  mov   rdi, EXIT_SUCCESS
  syscall
