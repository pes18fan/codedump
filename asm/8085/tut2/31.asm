; Bytes are stored from 4050h to 405Ah
; Insert 5 bytes after 4055h taking from 4040h
; But don't lose the previous content

lxi d, 4040h        ; source
lxi h, 4055h        ; dest
mvi c, 05h          ; counter

loop:
    mov  a, m
    mov  b, a
    ldax d
    mov  m, a
    mov  a, b
    stax d          ; store previous content in source table

next:
    inx  d
    inx  h
    dcr  c
    jnz  loop
    hlt
