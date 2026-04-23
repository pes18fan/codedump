; interface comon cathode 7-segment display at port 1
; binary codes to display digits 0 to 9 are stored in ROM, from 250h
; display 0 to 9 at port 1 using codes in ROM
org 0000h

mov dptr, #0250h
mov r7, #0ah

up:
    clr   a
    movc  a, @a+dptr
    mov   p1, a
    acall delay
    inc   dptr
    djnz  r7, up
    end

delay:
    mov r6, #ffh

delay2:
    mov  r5, #0fh
    djnz r5, delay2
    djnz r6, delay
    ret
