; Count the number of vowels in the string
; Display the string and its vowels in a clear screen
dosseg
.model small
.stack 32
.data
    buffer  db 100 dup("$")
    vowels  db 100 dup("$")
    newline db 0Ah, 0Dh, "$"
    count   db "Vowel count is: ", "$"

.code
    mov ax, @data
    mov ds, ax

    ; Read the string
    mov buffer, 50
    lea dx, buffer
    mov ah, 0Ah
    int 21h

    ; Print a newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Initialize counters
    mov cl, buffer[01]
    mov ch, 0
    mov si, 2
    mov di, 0
    mov bl, 0       ; Vowel count

    process_char:
        mov al, buffer[si]
        cmp al, "a"
        je  process_vowel
        cmp al, "e"
        je  process_vowel
        cmp al, "i"
        je  process_vowel
        cmp al, "o"
        je  process_vowel
        cmp al, "u"
        je  process_vowel
        cmp al, "A"
        je  process_vowel
        cmp al, "E"
        je  process_vowel
        cmp al, "I"
        je  process_vowel
        cmp al, "O"
        je  process_vowel
        cmp al, "U"
        je  process_vowel
        jmp next

    process_vowel:
        mov vowels[di], al
        inc bl
        inc di

    next:
        inc  si
        loop process_char

    ; Clear the screen
    mov ah, 0Fh
    int 10h         ; Get current video mode
    mov ah, 00h
    int 10h

    ; Print the count (assuming it's a single digit)
    lea dx, count
    mov ah, 09h
    int 21h
   
    mov dl, bl
    add dl, "0"     ; Convert digit to ASCII
    mov ah, 02h
    int 21h

    ; Print a newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Print the vowels
    lea dx, vowels
    mov ah, 09h
    int 21h

    ; Print a final newline
    lea dx, newline
    mov ah, 09h
    int 21h
    
    ; Exit
    mov ah, 4Ch
    int 21h
end
