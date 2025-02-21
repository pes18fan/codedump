; Read characters till a 'q' is encountered
; Then display the entered string
dosseg
.model small
.stack 32
.data
    buf db 100 dup("$")
    newline db 0Ah, 0Dh, "$"

.code
    mov ax, @data
    mov ds, ax

    ; Set indexes
    mov si, 0

    ; Read the characters
    read:
        mov ah, 01h
        int 21h
        cmp al, "q"
        je  final           ; Go to the end if a "q" is found

        mov buf[si], al     ; Move the read character to the buffer
        inc si
        jmp read

    final:
        ; Print a newline
        lea dx, newline
        mov ah, 09h
        int 21h

        ; Print the read string
        lea dx, buf
        mov ah, 09h
        int 21h

    ; Exit
    mov ah, 4Ch
    int 21h
end
