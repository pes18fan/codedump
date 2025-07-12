t = -2:0.01:2;
ramp = t .* (t >= 0);
plot(t, ramp, "linewidth", 1.5)
