t= -1:0.01:1;
unitstep = t >= 0;
subplot(1, 2, 1);
plot(t, unitstep, "linewidth", 1.5)
title("Unit step function")
xlabel("Time")
ylabel("Amplitude")

t = -1:0.01:1;
impulse = t == 0;
subplot(1, 2, 2);
stem(t, impulse)
title("Dirac delta function, discrete")
xlabel("Time")
ylabel("Amplitude")

sgtitle("Sadbhav Adhikari, 54")
