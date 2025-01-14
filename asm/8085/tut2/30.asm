; Ten bytes are stored from 4080h
; Transfer the first 5 numbers at the last 5 locations of the second table
; Rest at the start of it

; Second table isn't provided by the question, let it start at 4090h

lxi d, 4080h        ; source
lxi h, 4099h        ; dest
mvi c, 05h          ; counter

loop1:
    ldax d
    mov  m, a
    inx  d
    dcx  h
    dcr  c
    jnz  loop1

lxi h, 4090h
mvi c, 05h

loop2:
    ldax d
    mov  m, a
    inx  d
    inx  h 
    dcr  c
    jnz  loop2
    hlt
