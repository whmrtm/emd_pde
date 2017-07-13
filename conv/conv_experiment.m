

L = 100;
x = linspace(0,2,L);
signal = sin(2*pi.*x) + 0.5.*sin(0.8*pi.*x);

k = 1;
T = 100;



[mean_env, gau] = conv_mean_env(signal, k, T);




% Ts = linspace(0,2,20);
% for i = 1:20
%     T = Ts(i);
%     [mean_env, gau] = conv_mean_env(x, signal, k, T);
%     plot(mean_env);
%     hold on;
% end

% plot(signal);
% hold on;
% % plot(gau);
% plot(mean_env);
