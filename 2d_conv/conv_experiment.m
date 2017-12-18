% signal = imread('./img/lena_gray.tiff');
% signal = imread('./img/moon.tiff');
signal = imread('./img/lena512color.tiff');
% signal = imread('./img/fishingboat.jpg');
% signal = imread('./img/brickwall.bmp');
% signal = imread('./img/wood_texture.jpg');
% signal = imread('./img/CSF.jpg');
% signal = rgb2gray(signal);

signal = signal(:,:,1);

k = 1./(pi)^2;
% k = [1./(0.2*pi)^2, 1./(0.4*pi)^2, 1./(0.8*pi)^2];
T = 10; 
IMF_num = 4;
iter_num = 100;
signal = double(signal);
[IMFs, residual] = conv_emd(signal, k, T, iter_num, IMF_num, 0, 2, 0.01);

% Display the data
% Window
w = hamming(size(signal, 1));
signal = double(signal);
log_scale = 0;
figure;
subplot(121)
image(signal);
% mesh(signal);
colormap(gray(256));
subplot(122)
F = fft2(signal.*(w*w'));
if log_scale
    imagesc(log(abs(fftshift(F))));
else
    imagesc(abs(fftshift(F)));
end
suptitle('Signal');

for i = 1:IMF_num
    figure();
    subplot(121);
    image(IMFs(:,:,i)+126);
    % mesh(IMFs(:,:,i));
    colormap(gray(256));
    subplot(122);
    F = fft2(IMFs(:,:,i).*(w*w'));
    if log_scale
        imagesc(log(abs(fftshift(F))));
    else
        imagesc(abs(fftshift(F)));
    end
    suptitle(sprintf('IMF %d', i))

end

figure();
subplot(121)    
image(residual);
% mesh(residual);
colormap(gray(256));
subplot(122)
F = fft2(residual.*(w*w'));
if log_scale
    imagesc(log(abs(fftshift(F))));
else
    imagesc(abs(fftshift(F)));
end
% suptitle('Residual')
