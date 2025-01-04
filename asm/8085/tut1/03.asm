; Subtract value at 7071h from value at 7070h
; Set bit D2 and reset D5 of the result
; Store the final result at 7095h

lda 7071h   ; a <- [7071]
mov b, a    ; b <- a
lda 7070h   ; a <- [7070]
sub b       ; a <- a - b
ori 04h     ; a <- a | 04
ani DFh     ; a <- a & DF
sta 7095h   ; [7095] <- a
hlt
