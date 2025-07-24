clc;
clear all;
close all;

amp = 5;
fm = 2; % message frequency (binary)
fc = 10;  % carrier frequency
t = 0:0.001:1;

% carrier
x = amp * sin(2 * pi * fc * t);
subplot(3, 1, 1);
plot(t, x);
grid on;
xlabel("time");
ylabel("amplitude");
title("SA/Carrier Signal");
legend("carrier wave");

% message signal (bipolar square wave using sign function)
y = sign(sin(2 * pi * fm * t));
subplot(3, 1, 2);
plot(t, y);
grid on;
xlabel("time");
ylabel("amplitude");
title("SA/Message Signal");
legend("message signal");

% psk modulation (invert carrier phase based on message bit)
a = x .* y;
subplot(3, 1, 3);
plot(t, a);
grid on;
xlabel("time");
ylabel("amplitude");
title("SA/PSK Signal");
legend("PSK signal");
