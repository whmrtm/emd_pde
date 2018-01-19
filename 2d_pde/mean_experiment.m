% % Generate the signal
% img_size = 64;
% omega = 0.1*pi;


% [X,Y] = meshgrid(1:img_size);
% % Z = sin(omega.*X).*sin(omega.*Y);
% Z = sin(omega.*X + omega.*Y) + sin(-4*omega.*X + 8*omega.*Y);


% % Convert to 255 scale
% Z = (Z+1)./2;
% signal = Z*255;




% signal = imread('./img/lena_gray.tiff');
% signal = imread('./img/moon.tiff');
signal = imread('./img/lena512color.tiff');
% signal = imread('./img/fishingboat.jpg');
% signal = imread('./img/brickwall.bmp');
% signal = imread('./img/texture85.gif');
% signal = imread('./img/CSF.jpg');
% signal = imread('./img/Raffia.tiff');
% signal = rgb2gray(signal);

signal = signal(:,:,1);

k = 0.1;
T = 20;
signal(1,1)
mean_env = mean_envelope(signal, k, T);
mean_env(1,1)
residual = signal - mean_env;

% % Window
% w = hamming(size(signal, 1));
% log_scale = 1;
% figure;
% subplot(121)
% image(signal);
% colormap(gray(256));
% subplot(122)
% F = fft2(signal.*(w*w'));
% % F = fft2(signal);

% if log_scale
%     imagesc(log(abs(fftshift(F))));
% else
%     imagesc(abs(fftshift(F)));
% end
% % subtitle('Signal');

% figure();
% subplot(121);
% image(mean_env);
% colormap(gray(256));
% subplot(122);
% F = fft2(mean_env.*(w*w'));
% % F = fft2(signal);
% if log_scale
%     imagesc(log(abs(fftshift(F))));
% else
%     imagesc(abs(fftshift(F)));
% end
% % mesh(IMFs(:,:,i));    
% % subtitle(sprintf('IMF %d', i))

% figure();
% subplot(121)    
% image(residual);
% colormap(gray(256));
% subplot(122)
% F = fft2(residual.*(w*w'));
% % F = fft2(signal);
% if log_scale
%     imagesc(log(abs(fftshift(F))));
% else
%     imagesc(abs(fftshift(F)));
% end
% % mesh(residual);
% % subtitle('Residual')
