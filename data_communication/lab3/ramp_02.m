i = 1;
x = zeros(size(t)) % pre-allocate x to same size as t
for t = -2:0.01:2
   if t < 0
     x(i) = 0;
   else
     x(i) = t;
   end
   i = i + 1;
end
t = -2:0.01:2;
plot(t, x, "linewidth", 1.5)
title("Ramp functon")
xlabel("Time")
ylabel("Amplitude")
