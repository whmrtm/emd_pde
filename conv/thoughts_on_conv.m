% Use circular convolution for the discrete signal
L = 200;
x = linspace(0,2,L);
signal = sin(4*pi.*x);

% Gaussian filter

% fitler length
T = 10;
gau = 1./sqrt(4*pi*T).*exp( -(x-1).^2 ./(4.*T) );

mean_env = cconv(signal, gau, L);


% Plot
plot(gau); 
hold on;
plot(signal);
plot(mean_env);
legend('gaussian', 'signal', 'mean_env');
