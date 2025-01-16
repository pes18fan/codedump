; Ten bytes are stored from 6430h, and there's a second table at 6440h
; If a byte has bit D5 = 0 and D0 = 1, transfer it to second table
; Else transfer 00h

lxi d, 6430h        ; source
lxi h, 6440h        ; dest
mvi c, 0Ah          ; counter

loop:
    ldax d
    ani  21h
    cpi  01h
    ldax d
    jz   next
    mvi  a, 00h

next:
    mov  m, a
    inx  d
    inx  h
    dcr  c
    jnz  loop
    hlt
