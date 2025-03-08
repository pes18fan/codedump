; Add two random numbers and print the result
dosseg
.model small
.stack 32
.data
    a db 12h
    b db 13h
    newline db 0Ah, 0Dh, "$"
.code
    mov ax, @data
    mov ds, ax

    ; Add the two numbers
    mov bl, a
    add bl, b

    ; Now print the result. This is the hard part
    mov ax, bx
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

    ; Exit
    mov ah, 4Ch
    int 21h
end
