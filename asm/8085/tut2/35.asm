; Seven status and one control signal of a single microprocessor based
; instrument are stored sequentially from memory location 6000h
; Control bit is represented by bit D4, where D4 = 1 represents valid data
; And, there's some data starting from 7000h
; Transfer valid data to a new location
; Stop the checking process when all status signals are zero
; Count and display the number of valid data

lxi b, 6000h        ; status and control signals
lxi d, 7000h        ; source
lxi h, 9000h        ; destination (let)

loop:
    ldax b
    ani  10h        ; isolate control signal
    cpi  10h
    jnz  next
    
    ; transfer the valid data
    ldax d
    mov  m, a
    inx  h

next:
    ldax d
    inx  b
    inx  d
    ani  EFh        ; reset just the control signal
    cpi  00h        ; check if all status signals are zero
    jnz  loop
    hlt
