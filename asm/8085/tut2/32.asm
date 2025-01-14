; Transfer ten bytes from 5050h to 5060h
; But only if data is betwen 30h and 70h
; Else transfer 00h

lxi d, 5050h        ; source
lxi h, 5060h        ; dest
mvi c, 0Ah          ; counter

loop:
    ldax d
    cpi  31h
    jc   fail
    cpi  70h
    jc   next

fail:
    mvi  a, 00h 

next:
    mov  m, a
    inx  d
    inx  h
    dcr  c
    jnz  loop
    hlt
