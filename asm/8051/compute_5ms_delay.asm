; compute a precise 5 millisecond delay
; uses timers
; assumptions: 1 cycle = 1 microsecond, oscillator frequency = 12 MHz
; then, 5ms = 5000 microseconds = 5000 timer counts
; reload value = 65536 (timer limit) - 5000 = 60536 = #ec78h
delay5ms:
    mov tmod, #01h      ; set timer 0 to be in mode 1
    mov th0, #0ech
    mov tl0, #078h
    setb tr0            ; start timer 0

wait:
    jnb tf0, wait       ; wait till timer overflows
    clr tr0             ; stop timer
    clr tf0             ; clear overflow
    ret
