; Add numbers at locations 8080h and 8090h
; Save result at 80A0h

lda 8080h   ; a <- [8080]
mov b, a    ; b <- a
lda 8090h   ; a <- [8090]
add b       ; a <- a + b
sta 80A0h   ; [80A0] <- a
hlt
