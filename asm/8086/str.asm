; Read a string from the user
; Convert it to uppercase
; Count the number of words
; Display each word in each line
dosseg
.model small
.stack 32
.data
    buffer  db 100 dup("$")
    newline db 0Ah, 0Dh, "$"

.code
    mov ax, @data
    mov ds, ax

    ; Read the string
    mov buffer, 50
    lea dx, buffer
    mov ah, 0Ah
    int 21h

    ; Print the newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Convert to uppercase
    mov cl, buffer[01] 
    mov ch, 0
    mov si, 2

    process_char:
        mov al, buffer[si]
        cmp al, "a"
        jb  check_space
        cmp al, "z"
        ja  check_space
        sub al, 20h

    check_space:
        ; 20h is ASCII for space
        cmp  al, " "    
        jnz  print_char

        ; Print a newline on every space to separate words
        lea  dx, newline
        mov  ah, 09h
        int  21h
        jmp  next_char

    print_char:
        mov  dl, al
        mov  ah, 02h
        int  21h

    next_char:
        inc  si
        loop process_char

    ; Print another newline at the end
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Exit
    mov ax, 4C00h
    int 21h
end
