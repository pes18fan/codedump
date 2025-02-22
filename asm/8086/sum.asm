; Find the sum of x + 2x + 3x + 4x + ... to ten terms
; x is a two-digit number entered by the user
dosseg
.model small
.stack 32
.data
    prompt  db "Enter a number: ", "$"
    newline db 0Ah, 0Dh, "$"
    buffer  db 5 dup("$")
    coeff   db 1                ; Number to multiply x with on each term

.code
    mov ax, @data
    mov ds, ax

    ; Print the prompt
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Get the number
    mov buffer, 3
    lea dx, buffer
    mov ah, 0Ah
    int 21h

    ; Convert the input string to a number
    ; For simplicity just assume that the inputted string was a valid number
    mov al, 10
    sub buffer[02], "0"
    mul buffer[02]
    sub buffer[03], "0"
    add al, buffer[03]
    mov bl, al              ; x will be stored in bl

    ; Form the result, stored in si
    mov si, 0
    mov cx, 10

    start:
        mov  al, bl
        mul  coeff
        add  si, ax
        inc  coeff
        loop start

    ; Print a newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Print the result
    ; This necessitates converting the sum to ASCII first
    mov ax, si
    mov bx, 10              ; 'Cause we divide by 10 on each iteration
    mov cx, 0               ; Number of digits

    convert:
        xor  dx, dx         ; Clear dx
        div  bx
        push dx             ; Push the digit (remainder) on the stack
        inc  cx             ; Count the digit
        cmp  ax, 0
        jne  convert        ; Keep converting till the quotient is zero

    ; Retrieve the digits in reverse order, convert, and print one by one
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
