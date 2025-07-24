clc;
clear all;
close all;

amp = 5;
fp = 4;
fc1 = 50;
fc2 = 100;
t = 0:0.001:1;

c1 = (amp / 2) * sin(2 * pi * fc1 * t);
c2 = (amp / 2) * sin(2 * pi * fc2 * t);

subplot(4, 1, 1);
plot(t, c1);
grid on;
xlabel("time");
ylabel("amplitude");
title("SA/Carrier Signal 1");
legend("carrier wave 1");

subplot(4, 1, 2);
plot(t, c2);
grid on;
xlabel("time");
ylabel("amplitude");
title("SA/Carrier Signal 2");
legend("carrier wave 2");

% manually create square wave: 0 to amp (like unipolar square)
m = (amp/2) * (sign(sin(2 * pi * fp * t)) + 1);

subplot(4, 1, 3);
plot(t, m);
grid on;
xlabel("time");
ylabel("amplitude");
title("SA/Message Signal");
legend("message signal");

% fsk modulation
a = zeros(size(t));  % preallocate memory
for i = 1:length(t)
  if m(i) == 0
    a(i) = c2(i);  % binary 0 as fc2
  else
    a(i) = c1(i); % binary 1 as fc1
  endif
end

subplot(4, 1, 4);
plot(t, a);
grid on;
xlabel("time");
ylabel("amplitude");
title("SA/FSK Signal");
legend("FSK signal");
