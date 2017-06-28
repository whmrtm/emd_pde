x = linspace(0, 4, 100);
omega = 2*pi;
s1 = cos(omega*x);
s1_dp = -omega.^2*s1;
a = 0.02;


% s = s1 + a*s1_dp;
s = -a*s1_dp;

plot(x,s1)
hold on;
plot(x,s)

