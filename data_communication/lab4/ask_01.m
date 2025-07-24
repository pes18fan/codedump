clc;
clear all;
close all;

amp = 5;
fp = 4;
fc = 50;
t = 0:0.001:1;

x = amp * sin(2 * pi * fc * t);
subplot(3, 1, 1);
plot(t, x);
grid on;
xlabel("time");
ylabel("amplitude");
title("SA/Carrier Signal");
legend("carrier wave");

% manually create square wave: 0 to amp (like unipolar square)
y = (amp/2) * (sign(sin(2 * pi * fp * t)) + 1);

subplot(3, 1, 2);
plot(t, y);
grid on;
xlabel("time");
ylabel("amplitude");
title("SA/Message Signal");
legend("message signal");

a = x .* y;
subplot(3, 1, 3);
plot(t, a);
grid on;
xlabel("time");
ylabel("amplitude");
title("SA/ASK Signal");
legend("ASK signal");
