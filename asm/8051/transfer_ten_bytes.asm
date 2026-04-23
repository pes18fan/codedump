; transfer 10 bytes starting at 45h, to 70h
org 0000h

mov r0, #45h
mov r1, #70h
mov r7, #0ah

up:
    mov  a, @r0
    mov  @r1, a
    inc  r0
    inc  r1
    djnz r7, up
    end
