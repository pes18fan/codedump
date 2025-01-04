; Set auxiliary carry flag and reset parity flag
; Don't affect other flags

lxi sp, 9000h   ; sp <- 9000
push psw        ; [8FFF] <- a, [8FFE] <- f
pop b           ; b <- [8FFF], c <- [8FFE]
mov a, c        ; a <- c
ori 10h         ; a <- a | 10
ani FBh         ; a <- a & FB
mov c, a        ; c <- a
push b          ; [8FFF] <- b, [8FFE] <- c
pop psw         ; a <- [8FFF], f <- [8FFE]
hlt
