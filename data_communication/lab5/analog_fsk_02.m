clc;
close all;
clear all;

t = 0:0.001:1;

% define signal parameters
fm = 5;
am = 1;
fc = 50;
ac = 5;
kf = 10;  % frequency sensitivity (modulation constant)

x = am * cos(2 * pi * fm * t); % message signal
c = ac * cos(2 * pi * fc * t); % carrier signal
b = (kf * am) / fm; % modulation index
A = ac * cos(2 * pi * fc * t + b * sin(2 * pi * fm * t)); % fm signal

subplot(3, 1, 1)
plot(t, x);
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
plot(t, A);
xlabel("Time (s)");
ylabel("Amplitude");
title("Frequency Modulated Signal - SA");
grid on;
