; Ten bytes are in tables 5270h and 5280h
; If a byte has even parity, transfer if to 5280h
; Else transfer it to 5280h only after clearing bit D7 and setting D2

lxi d, 5270h        ; source
lxi h, 5280h        ; dest
mvi c, 0Ah          ; counter

loop:
    ldax d
    cpi  00h
    jpe  next
    ani  7Fh
    ori  04h

next:
    mov  m, a
    inx  d
    inx  h
    dcr  c
    jnz  loop
    hlt
