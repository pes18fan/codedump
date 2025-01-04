; If the content of 2050h is greater than or equal to 64h, display 0Fh
; Else display FFh

lda 2050h      ; a <- [2050]
cpi 64h         ; a - 64
jc fallback
mvi a, 0Fh      ; a <- 0F
jmp display

fallback:
    mvi a, 0FFh ; a <- FF

display:
    out 01h
    hlt
