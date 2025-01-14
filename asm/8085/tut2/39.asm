; Find the sum of x + (x + 5d) + (x + 10d) + ... to ten terms
; Where, x is a byte at location 8085h and d is the value in register d
; Store the 16-bit result at location 8086h

mvi a, 01h
sta 8085h
mvi d, 01h

mvi c, 0Ah          ; count, given as 0A in hex
mov a, c
sui 01h
mov c, a            ; actually loop count - 1 times, as we start the sum with x

mvi a, 00h
sta 9000h           ; multiples to the offset to the term (5, 10, 15, ...)

mvi e, 00h          ; offset to each term (5d, 10d, 15d, ...)
mvi h, 00h          ; carry

lda 8085h
mov l, a            ; sum, preload with x

loop:
    lda 8085h
    add l
    mov l, a
    jnc refill
    inr h

refill:
    lda 9000h
    adi 05h
    sta 9000h
    mov b, a
    mvi a, 00h

loop2:
    add d
    mov e, a
    dcr b
    jnz loop2
    mov a, l
    add e
    mov l, a
    jnc next
    inr h

next:
    dcr c
    jnz loop

shld 8086h
hlt
