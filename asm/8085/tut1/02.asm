; Load 7Dh into b and 9Fh into c
; Add them, complement the result
; Store the final result in F0F0h

mvi b, 7Dh  ; b <- 7D
mvi c, 9Fh  ; c <- 9F
mov a, b    ; b <- a
add c       ; a <- a + c
cma         ; a <- a'
sta F0F0h   ; [F0F0] <- a
hlt
