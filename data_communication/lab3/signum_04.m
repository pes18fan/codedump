i = 1;
x = zeros(size(t)); % pre-allocate to x to same size as t
for t = -1:0.01:1
  if t < 0
    x(i) = -1;
  elseif t > 0
    x(i) = 1;
  else
    x(i) = 0;
  end
  i = i + 1;
end
t = -1:0.01:1;
plot(t, x, "linewidth", 1.5)
title("Signum functon");
xlabel("Time");
ylabel("Amplitude");
