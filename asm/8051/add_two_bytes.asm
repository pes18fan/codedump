; add two bytes at 45h and 46h, display result in port 1
org 0000h

mov a, 45h
add a, 46h
mov p1, a
end
