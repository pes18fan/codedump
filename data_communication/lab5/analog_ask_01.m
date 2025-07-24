clc;
close all;
clear all;

t = 0:0.001:1;

% define signal parameters
fm = 5;
am = 1;
fc = 50;
ac = 5;

m = am * sin(2 * pi * fm * t) % message signal
c = ac * sin(2 * pi * fc * t) % carrier signal

mod = (1 * (m / ac)) .* c;  % standard AM signal

subplot(3, 1, 1)
plot(t, m);
xlabel("Time (s)");
ylabel("Amplitude")
title("Message Signal - SA");
grid on;

subplot(3, 1, 2);
plot(t, c);
xlabel("Time (s)");
ylabel("Amplitude");
title("Carrier Signal - SA");
grid on;

subplot(3, 1, 3);
plot(t, mod);
xlabel("Time (s)");
ylabel("Amplitude");
title("Amplitude Modeling Signal - SA");
grid on;
