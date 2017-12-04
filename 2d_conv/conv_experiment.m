% signal = imread('./img/lena_gray.tiff');
% signal = imread('./img/moon.tiff');
% signal = imread('./img/lena512color.tiff');
% signal = imread('./img/fishingboat.jpg');
% signal = imread('./img/brickwall.bmp');
signal = imread('./img/wood_texture.jpg');
% signal = imread('./img/CSF.jpg');
% signal = rgb2gray(signal);

signal = signal(:,:,1);


k = 1./2*(0.1*pi)^2;
T = 50;
IMF_num = 3;
iter_num = 20;
[IMFs, residual] = conv_emd(signal, k, T, iter_num, IMF_num, 1, 1, 0.01);

% Display the data
figure;
subplot(121)
image(signal);
colormap(gray(256));
subplot(122)
F = fft2(signal);
imagesc(log(abs(fftshift(F))));
suptitle('Signal');

for i = 1:IMF_num
    figure();
    subplot(121);
    image(IMFs(:,:,i));
    colormap(gray(256));
    subplot(122);
    F = fft2(IMFs(:,:,i));
    imagesc(log(abs(fftshift(F))));
    % mesh(IMFs(:,:,i));    
    suptitle(sprintf('IMF %d', i))

end

figure();
subplot(121)
image(residual);
colormap(gray(256));
subplot(122)
F = fft2(residual);
imagesc(log(abs(fftshift(F))));
% mesh(residual);
suptitle('Residual')
