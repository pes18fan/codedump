t = 0:0.01:2;
a = 5;
f = 1;

y1 = a * sin(2 * pi * f * t);
x = t;
subplot(2, 2, 1)
plot(x, y1);
grid on;

title("CT sine wave")
xlabel("Time");
ylabel("Amplitude");

y2 = a * cos(2 * pi * f * t);
subplot(2, 2, 2);
plot(x, y2);
grid on;

title("CT cosine wave")
xlabel("Time");
ylabel("Amplitude");

subplot(2, 2, 3);
stem(x, y1);
grid on;

title("DT sine wave")
xlabel("Time");
ylabel("Amplitude");

subplot(2, 2, 4);
stem(x, y2);
grid on;

title("DT cosine wave")
xlabel("Time");
ylabel("Amplitude");

