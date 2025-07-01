t = 0:0.01:2;
a = 5;
f = 1;

y = a * sin(2 * pi * f * t);
ns = rand(1, length(t));

subplot(2, 2, 1)
plot(t, y)

title("Original sine wave")
xlabel("Time")
ylabel("Amplitude")

subplot(2, 2, 2)
plot(t, ns)

title("The added noise");
xlabel("Time");
ylabel("Amplitude");

subplot(2, 1, 2)
plot(t, ns + y)

title("Sine wave with added noise");
xlabel("Time");
ylabel("Amplitude");


sgtitle("Noisy sine wave, Sadbhav Adhikari, ACE079BCT054")