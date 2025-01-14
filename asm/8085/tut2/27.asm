; Two tables starting at 3000h and 4000h have 50 bytes of data
; A third table starts from 5000h
; Find sum of each data from first and second tables
; If the sum is between C0h and FFh, store it in third table
; Else store 00h in that location

lxi d, 3000h        ; table 1
lxi h, 5000h        ; dest
mvi c, 32h          ; counter, holds 50 in hex

loop:
    ; place corresponding value of 2nd table in b
    mov  a, d
    adi  10h
    mov  d, a
    ldax d
    mov  b, a

    ; place corresponding value of 1st table in a
    mov  a, d
    sub  10h
    mov  d, a
    ldax d

    ; sum a and b 
    ; if C0h < sum < FFh, store it in 3rd table
    ; else store 00h
    add  b
    cpi  C1h
    jc   fail
    cpi  FFh
    jnc  fail
    jmp  next

fail:
    mvi  a, 00h

next:
    mov  m, a
    inx  d
    inx  h
    dcr  c
    jnz  loop
    hlt
