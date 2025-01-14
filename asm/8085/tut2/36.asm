; Add ten 8 bit BCD numbers in a table
; Store the 16 bit result at the end of table

; Let the table be 6000h

lxi h, 6000h        ; source
mvi c, 0Ah          ; counter
mvi e, 00h          ; sum
mvi d, 00h          ; carry

loop:
    mov a, m
    add e
    daa
    mov e, a
    jnc next
    inr d           ; add the carry

next:
    inx h
    dcr c
    jnz loop

mov m, e
inx h
mov m, d
hlt
