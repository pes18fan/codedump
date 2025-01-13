; Find the smallest number among ten numbers
; The ten numbers are stored from memory location 4500h

lxi h, 4500h
mvi a, 00h
mvi c, 0Ah

loop:
    mov b, m
    cmp b
    jnc next
    mov a, b

next:
    inx h
    dcr c
    jnz loop
    hlt
