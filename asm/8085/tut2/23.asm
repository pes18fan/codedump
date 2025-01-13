; A table has ten 8 bit data starting from 8050h
; Store the sum of odd numbers at 8060h and that of even nums at 8070h
; Display the sums at two different ports

lxi h, 8050h        ; source
mvi c, 0Ah          ; counter
mvi d, 00h          ; even sum
mvi e, 00h          ; odd sum

loop:
    mov a, m
    ani 01h         ; isolate the LSB, if zero flag sets the number is even
    jz  even
    mov a, m
    add e
    mov e, a
    jmp next

even:
    mov a, m
    add d
    mov d, a

next:
    inx h
    dcr c
    jnz loop
    
mov a, d
out 00h             ; show even sum
sta 8070h           ; move even sum

mov a, e
out 01h             ; show odd sum
sta 8060h           ; move odd sum
hlt
