; Ten bytes stored in two tables
; Add corresponding bytes if the byte in the first table is smaller than second
; Else subtract second from first
; Store results of each op in corresponding location of third table

; Let first table be 5050h, second be 5060h and third be 5070h

lxi d, 5050h        ; source
lxi h, 5070h        ; dest
mvi c, 0Ah          ; counter

loop:
    ; place corresponding value of 2nd table in b
    mov  a, e
    adi  10h
    mov  e, a
    ldax d
    mov  b, a

    ; place corresponding value of 1st table in a
    mov  a, e
    sub  10h
    mov  e, a
    ldax d

    ; compare value in 1st table to 2nd
    ; if a is smaller do a + b; else a - b
    cmp  b
    jnc  fail
    add  b
    jmp  next

fail:
    sub  b

next:
    mov  m, a
    inx  d
    inx  h
    dcr  c
    jnz  loop
    hlt
