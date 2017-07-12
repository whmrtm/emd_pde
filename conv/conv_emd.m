L = 100;
x = linspace(0,2,L);
signal = sin(2*pi.*x) + 0.5.*sin(0.8*pi.*x);

T = 0.5;
[mean_env, gau] = conv_mean_env(x, signal, T);

% plot(signal);
% hold on;
% % plot(gau);
% plot(mean_env);
