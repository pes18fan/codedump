; Retrieve a value from 2050h
; Display it if its even, else store FFh in 2050h if odd

lda 2050h      ; a <- [2050]
ani 01h         ; a <- a & 01, isolate the LSB
cpi 01h         ; a - 01, if the LSB is 1 the number is odd, else even
jc even
jmp odd

even:
    ldax 2050h      ; a <- [2050]
    out 01h

odd:
    mvi a, 0FFh     ; a <- FF
    sta 2050h
    hlt
