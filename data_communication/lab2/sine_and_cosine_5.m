t = 0:0.01:2;
a = 5;
f = 1;

y1 = a * sin(2 * pi * f * t);
x = t;
plot(x, y1);
hold on;

y2 = a * cos(2 * pi * f * t);
plot(x, y2);

title("Sine and cosine waves, Sadbhav Adhikari, ACE079BCT054")
xlabel("Time");
ylabel("Amplitude");
legend("Sine", "Cosine");
grid on;