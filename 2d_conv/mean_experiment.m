% Demo of mean envelope extraction
L = 400;
x = linspace(0,6,L);

% signal = sin(2*pi.*x) + 0.5.*sin(0.8*pi.*x);

k = 1./(4*pi^2);
T = 30;


signal = imread('moon.tif');
mean_env = conv_mean_env(signal, k, T);

% Ts = linspace(0,2,20);
% for i = 1:20
%     T = Ts(i);
%     [mean_env, gau] = conv_mean_env(x, signal, k, T);
%     plot(mean_env);
%     hold on;
% end


% plot the result
figure();
subplot(1,2,1);
imshow(signal);
subplot(1,2,2);
imshow(mean_env);
