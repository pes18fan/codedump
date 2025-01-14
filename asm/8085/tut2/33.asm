; Swap bit D3 and D6 of sixteen numbers stored in memory from 9650h
; But only if number is greater than 70h and less than A0h
; Else set D3 and reset D6 of the numbers stored

lxi h, 9650h        ; source
mvi c, 10h          ; counter

loop:
    mov a, m    
    cpi 71h     
    jc  setunset 
    cpi A0h     
    jnc setunset

swap:
    ani 48h    
    cpi 00h    
    jz  next 
    cpi 48h    
    jz  next 
    mov a, m   
    xri 48h    
    mov m, a   
    jmp next

setunset:
    ori 08h 
    ani BFh 
    mov m, a

next:
    inx h   
    dcr c   
    jnz loop
    hlt
