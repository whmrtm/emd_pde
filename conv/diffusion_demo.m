% Initialization
L = 400;
signal = zeros(1,L);
x = linspace(-2,2,L);
signal(100:300) = 1;
plot(x, signal);
hold on;

k = 1;
T = 10;
sigma = sqrt(2*k*T);
c = x(end)/2;
gau = exp(-(x-c) .^ 2 / (2 * sigma ^ 2));
% gau = gau./sum(gau);

diffusion = conv(signal, gau);
plot(x, gau)