; Reverse a string
dosseg
.model small
.stack 32
.data
    buf db 100 dup("$")
    res db 100 dup("$")
    newline db 0Ah, 0Dh, "$"

.code
    mov ax, @data
    mov ds, ax

    ; Read the string
    mov buf, 50
    lea dx, buf
    mov ah, 0Ah
    int 21h

    ; Print a newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Set up the indexes
    mov cl, buf[01]
    mov ch, 0
    mov si, 1
    add si, cl      ; Start the source index at the index of the last character
    mov di, 0

    ; Put the reversed value in `res`
    start:
        mov al, buf[si]
        mov res[di], al
        dec si
        inc di
        loop start

    ; Print the reversed string
    lea dx, res
    mov ah, 09h
    int 21h

    ; Exit
    mov ah, 4Ch
    int 21h
end
