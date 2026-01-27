t = 0:0.01:2;
a = 5;
f = 1;

y1 = a * cos(2 * pi * f * t);
x = t;
plot(x, y1);
hold on;
plot(t, zeros(size(t)))

title("CT cosine wave")
xlabel("Time");
ylabel("Amplitude");
legend("Sine", "Zero line");
grid on;
