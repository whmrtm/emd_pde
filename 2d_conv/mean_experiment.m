% k = 1./2*(100*pi)^2;

k = 1./((pi)^2);
T = 100;

signal = imread('./img/fishingboat.jpg');
% signal = imread('./img/texture_1.jpg');

% signal = rgb2gray(signal);
signal = double(signal(:,:,1));
figure;
mesh(signal);
% image(signal)
% colormap(gray(256));

mean_env = conv_mean_env(signal, k, T);

figure;
mesh(mean_env);
% image(mean_env)
% colormap(gray(256));

residual = signal - mean_env;
figure;
mesh(residual);
% image(residual)
% colormap(gray(256));













% Ts = linspace(0,2,20);
% for i = 1:20
%     T = Ts(i);
%     [mean_env, gau] = conv_mean_env(x, signal, k, T);
%     plot(mean_env);
%     hold on;
% end



% % plot the result
% figure();
% subplot(1,3,1);
% imshow(signal);
% title('signal')
% subplot(1,3,2);
% imshow(mean_env);
% title('mean surface')
% subplot(1,3,3);
% imshow(signal-mean_env);
% title('residual')