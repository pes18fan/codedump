; Ten bytes are in memory starting from 8345h
; Convert each binary number into a BCD
; Store the result in the second table i.e. location starting from 8365h
; Make a subroutine for the conversion

lxi d, 8345h        ; source
lxi h, 8445h        ; dest
mvi c, 0Ah          ; counter

loop:
    call convert

next:
    inx  d
    inx  h
    dcr  c
    jnz  loop
    hlt

convert:
    ldax d
    daa
    mov  m, a
    ret
