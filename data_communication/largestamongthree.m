a = input("Give me the first number. ");
b = input("Give me the second number. ");
c = input("Give me the third number. ");

if a > b && a > c
    fprintf("a = %d is largest\n", a);
elseif b > c
    fprintf("b = %d is largest\n", b);
else
    fprintf("c = %d is largest\n", c)
end