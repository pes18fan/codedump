; add two 8-bit BCD data in 50h and 52h, store BCD results in 52h and 53h
org 0000h

mov a, 50h
add a, 51h
daa
mov 53h, a
clr a
mov acc.0, c
mov 52h, a
end
