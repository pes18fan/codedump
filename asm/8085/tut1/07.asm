; Add numbers at 3030h and 4040h
; Display sum on Port 1, if there's a carry show it on Port 2
; Store sum in 5050h

lda 3030h   ; a <- [3030]
mov b, a    ; b <- a
lda 4040h   ; a <- [4040]
add b       ; a <- a + b
out 01h
jnc store
mov b, a    ; b <- a
mvi a, 01h  ; a <- 01
out 02h 
mov a, b    ; a <- b

store:
    sta 5050h   ; [5050] <- a

hlt
