x = [2, 7, 17, 24];
y = [5. 8, 9, 13];

% plot() plots continuous graphs, can modify the look of it through params
plot(x, y, "--", "linewidth", 4)
hold on

% stem() plots discrete graphs, can modify its look through params too
stem(x, y, "filled", "markerfacecolor", "r")

title("Straight lines")
xlabel("X-axis")
ylabel("Y-axis")
legend("line")
grid on;
