; 8 LEDs are connected in port 2 of the 8051 controller
; write a program to blink them
org 0000h

clr p1

start:
    xrl   p1, #ffh
    acall delay
    sjmp  start

delay:
    mov r6, #ffh

delay2:
    mov  r5, #0fh
    djnz r5, delay2
    djnz r6, delay
    ret
