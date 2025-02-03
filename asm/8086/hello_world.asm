dosseg
.model small
.data
    msg db "Hello, world!", 0Ah, 0Dh, "$"

.code
    mov ax, @data
    mov ds, ax
    mov ah, 09h
    lea dx, msg
    int 21h

    mov ax, 4C00h
    int 21h
end
