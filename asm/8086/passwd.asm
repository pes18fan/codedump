; Ask the user for a password
; Tell the user if its correct or not
dosseg
.model small
.stack 32
.data
    ; please never store passwords unencrypted like this irl :skull:
    passwd db "korrekt", "$"
    passwd_len equ ($ - passwd - 1)
    newline db 0Ah, 0Dh, "$"
    buf db 100 dup("$")
    prompt db "Enter the password: ", "$"
    match db "The password is correct!", "$"
    no_match db "The password is incorrect.", "$"
.code
    mov ax, @data
    mov ds, ax

    ; Print the prompt
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Read the string
    mov buf, 50
    lea dx, buf
    mov ah, 0Ah
    int 21h

    ; Print a newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Get input length
    mov cl, buf[1]

    ; Check if lengths match
    cmp cl, passwd_len
    jne incorrect

    ; Compare the passwords
    mov si, 2
    mov di, 0

    start:
        cmp  cl, 0
        je   correct
        mov  al, buf[si]
        cmp  al, passwd[di]
        jne  incorrect
        inc  si
        inc  di
        dec  cl
        jmp  start

    incorrect:
        lea dx, no_match
        mov ah, 09h
        int 21h
        jmp exit

    correct:
        lea dx, match
        mov ah, 09h
        int 21h

    exit:
        mov ah, 4Ch
        int 21h
end
