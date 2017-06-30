x = linspace(0,1,100);
signal = sin(2*pi*x);
a = 0.1;
T = 10;
gaussian = 1./sqrt(4*pi*a*T) .* exp(-x.*2./(4*a*T));
mean_envelope = conv(gaussian, signal);


figure;
plot(signal);
hold on;
plot(mean_envelope);


% The length of two signals are different
legend('signal','mean envelope')'


