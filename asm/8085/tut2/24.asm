; We have a table of 8-bit numbers
; Add all numbers there whose higher nibble is greater than 6
; Store the 16 bit result just after the table
; (Assuming 10 data)

; Consider the source table = 9000h

lxi h, 9050h
mvi c, 0Ah
mvi d, 00h          ; store carry
mvi e, 00h          ; store sum

loop:
    mov  a, m
    ani  F0h        ; separate higher nibble
    cpi  07h
    jc   next
    add  e
    jnc  next
    inr  d

next:
    inx  h
    dcr  c
    jnz  loop

mov a, e
mov m, a
inx h
mov a, d
mov m, a
hlt
