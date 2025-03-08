; Generate the Fibonacci series upto 10 terms
dosseg
.model small
.stack 32
.data
    seq dw 100 dup(?)
    newline db 0Ah, 0Dh, "$"
.code
    mov ax, @data
    mov ds, ax

    ; Put the first two terms in the sequence
    mov seq[0], 0
    mov seq[2], 1

    mov ax, 0   ; First Fibonacci term
    mov bx, 1   ; Second Fibonacci term
    mov cx, 8   ; Number of terms minus first 2 terms
    mov si, 4

    generate:
        xor  dx, dx      ; Clear `dx` to store the next term
        add  dx, ax
        add  dx, bx
        mov  seq[si], dx
        mov  ax, bx
        mov  bx, dx
        add  si, 2
        loop generate

    ; Now print all the terms
    ; Remember, you need to convert them to ASCII too
    mov si, 0
    
    print_all:
        mov ax, seq[si]
        mov bx, 10
        mov cx, 0

        ; Isolate each digit and place on stack
        grab_digit:
            xor  dx, dx
            div  bx
            push dx
            inc  cx
            cmp  ax, 0
            jne  grab_digit

        ; Retrieve digits, convert to ASCII and print
        print:
            pop  dx
            add  dl, "0"
            mov  ah, 02h
            int  21h
            loop print

        ; Print a newline
        lea dx, newline
        mov ah, 09h
        int 21h

        add si, 2
        cmp si, 20
        jne print_all

    ; Exit
    mov ah, 4Ch
    int 21h
end
