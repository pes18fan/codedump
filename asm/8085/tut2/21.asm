; Transfer ten 8 bit numbers from one table to another
; But only if sum of higher and lower nibble is less than 10h
; Else store 00h

; The question doesn't provide the tables, so let source be 9050h
; And let dest be 9070h

lxi h, 9050h    ; source
lxi d, 9070h    ; dest
mvi c, 08h      ; counter

loop:
    mov a, m
    ani 0Fh         ; separate lower nibble
    mov b, a
    mov a, m
    ani F0h         ; separate upper nibble
    rrc
    rrc
    rrc
    rrc
    add b           ; add nibbles
    cpi 10h
    jnc fail
    mov a, m
    stax d
    jmp next

fail:
    mvi a, 00h
    stax d

next:
    inx h
    inx d
    dcr c
    jnz loop
    hlt
