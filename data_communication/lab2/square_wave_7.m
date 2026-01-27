t = 0:0.01:2;
a = 5;
f = 1;

y = a * sign(sin(2 * pi * f * t));

plot(t, y)

title("Square sine wave");
xlabel("Time");
ylabel("Amplitude");
