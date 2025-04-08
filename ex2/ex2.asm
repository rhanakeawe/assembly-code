;exam2_01.asm
;short Year[10] = {1000, 1900, 1980, 2000, 2010, 2020, 2024, 2030, 2040, 2050};
//16-bit array
;short leap[10]; //16-bit non-initial array
;register long rsi = 0 //64-bit register
;register long rdi = 0 //64-bit register
;register long rcx = 10 //64-bit register
;do {
; if((year[rsi]%400 == 0) || ((year[rsi]%4 == 0) && (year[rsi]%100 != 0)))
; {
; leap[rdi] = year[rsi]; //store to leap[rdi]
; rdi++; //rdi = rdi + 1
; }
; rsi++; //rsi = rsi + 1
; rcx--; //rcx = rcx - 1
;} while(rcx != 0); //if rcx != 0 do loop again

section .data
  year dw 1000, 1900, 1980, 2000, 2010, 2020, 2024, 2030, 2040, 2050
section .bss
  leap resw 10
section .text
  global _start
_start:
  mov rsi, 0
  mov rdi, 0
  mov rcx, 10
check400:
  mov ax, word[year+(rsi*2)]
  mov dx, 0
  mov bx, 400
  div bx
  cmp dx, 0
  je leap_yr
check4:
  mov ax, word[year+(rsi*2)]
  mov dx, 0
  mov bx, 4
  div bx
  cmp dx, 0
  jne not_leap
check100:
  mov ax, word[year+(rsi*2)]
  mov dx, 0
  mov bx, 100
  div bx
  cmp dx, 0
  je not_leap
leap_yr:
  mov ax, word[year+(rsi*2)]
  mov word[leap+(rdi*2)], ax
  inc rdi
not_leap:
  inc rsi
  loop check400
_stop:
  mov rax, 60
  mov rdi, 0
  syscall
