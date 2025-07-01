% Divide the figure into 2 rows and 1 column, each cell capable of having a
% separate figure

x = [2, 7, 8]
y = [5, 7, 12]
subplot(2, 1, 1)
plot(x, y, "--", "linewidth", 4)
title("Subplot 1, Sadbhav Adhikari, ACE079BCT054")
xlabel("X-axis")
ylabel("Y-axis")

subplot(2, 1, 2)
stem(x, y, "filled")
title("Subplot 2, Sadbhav Adhikari, ACE079BCT054")
xlabel("X-axis")
ylabel("Y-axis")

grid on;
