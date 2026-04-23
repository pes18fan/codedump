; an LED is connected to 1.7 and switch at 1.1
; generate a pulse of 75% duty cycle at pin 1.7 when switch at 1.1 is on
org 0000h

; Consider that the time period is 800 units (#800)

start:
    clr p1.7
    acall wait

    setb  p1.7      ; output high
    acall delay3    ; keep high for 3 units

    clr   p1.7      ; output low
    acall delay1    ; keep low for 1 unit

    sjmp  start

delay1:
    mov r7, #200
d1: djnz r7, d1
    ret

delay3:
    mov r7, #600
d3: djnz r7, d3
    ret

wait:
    jnb p1.1, wait 
    ret
