; Ten bytes are stored in tables 5050h and 5060h
; Transfer data of 1st table to 3rd table starting at 5070h
; But only if data in 1st table is greater than that in 2nd
; Else, store 00h in 3rd table

lxi d, 5050h        ; source
lxi h, 5070h        ; dest
mvi c, 0Ah          ; counter

loop:
    ; place the corresponding value of 2nd table in b
    mov  a, e
    adi  10h
    mov  e, a
    ldax d
    adi  01h
    mov  b, a

    ; compare value in 1st table to 2nd
    ; if a is larger, transfer; else transfer 00h instead
    mov  a, e
    sub  10h
    mov  e, a
    ldax d
    cmp  b
    jnc  next
    mvi  a, 00h

next:
    mov  m, a
    inx  d
    inx  h
    dcr  c
    jnz  loop
    hlt
