;exam1_1.asm
;signed int num1 = +3100000; //32-bit signed variable
;signed int num2 = +1700000; //32-bit signed variable
;signed int num3 = -333333; //32-bit signed variable
;signed long sum = 0 //64-bit signed variable
;signed int quo = 0; //32-bit signed variable
;signed int rmd = 0; //32-bit signed variable
;sum = long(num1 + num2);
;quo = sum / num3;
;rmd = sum % num3;
section .data
  num1 dd +3100000 ;num1 = 0x002F 4D60
  num2 dd +1700000 ;num2 = 0x0019 F0A0
  num3 dd -333333 ;num3 = 0xFFFA E9E8
  sum dq 0 ;sum = 0x0000 0000 0000 0000
  quo dd 0 ;quo = 0x0000 0000
  rmd dd 0 ;rmd = 0x0000 0000
section .text
  global _start
_start:
  mov edx, 0
  mov eax, dword[num1] ;eax = [num1] = 0x002F 4D60
  add eax, dword[num2] ;eax = eax+[num2] = 0x0049 3E00
  adc edx, 0 ;edx = edx + 0 + CF = 0x0000 0000
  mov dword[sum], eax ;[sum] = eax = 0x0012 4F80
  mov dword[sum+4], edx ;[sum+4] = edx = 0x0000 0000
  ;[sum] = 4,800,000
  mov eax, dword[sum] ;eax = [sum] 0x0012 4F80
  mov edx, dword[sum+4] ;edx = [sum+4] = 0x0000 0000
  idiv dword[num3] ;eax = edx:eax/[num3], edx = edx:eax%[num3]
  mov dword[quo], eax ;quo = eax = 0xFFFF FFF2 = -14
  mov dword[rmd], edx ;rmd = edx = 0x0002 08DA = 133338
  mov rax, 60 ;terminate executing process
  mov rdi, 0 ;exit status
  syscall
