; Set bit D2 of d and reset bit D5 of e
; Store the final value of d in 8050 and that of e in 8060

mov a, d    ; a <- d
ori 04h     ; a <- a | 04
sta 8050h   ; [8050] <- a
mov a, e    ; a <- e
ani DFh     ; a <- a & DF
sta 8060h   ; [8060] <- a
hlt
