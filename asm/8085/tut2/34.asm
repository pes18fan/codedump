; This question gave me a REALLY hard time
; This program may thus have issues; please let me know if it does

; Transfer ten bytes from 9080h to 9090h
; Only if bit D5 is set and D3 is reset
; Else transfer them after swapping D2 and D6

lxi d, 9080h        ; source
lxi h, 9090h        ; dest
mvi c, 0Ah          ; counter

loop:
    ldax d
    ani  28h
    cpi  20h
    jz   next
    ldax d
    ani  44h
    cpi  00h
    jz   next
    cpi  44h
    jz   next
    ldax d
    xri  44h 

next:
    ldax d
    mov  m, a    
    inx  d
    inx  h   
    dcr  c   
    jnz  loop
    hlt
