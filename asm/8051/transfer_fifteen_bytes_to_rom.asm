; transfer fifteen bytes from 40h in RAM, to 250h in ROM
org 0000h

mov r0, #40h
mov dptr, #0250h
mov r7, #0fh

up:
    mov  a, #00h
    movc a, @a+dptr
    mov  @r0, a
    inc  r0
    inc  dptr
    djnz r7, up
    end
