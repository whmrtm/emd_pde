% signal = imread('./img/lena_gray.tiff');
% signal = imread('./img/moon.tiff');
% signal = imread('./img/lena512color.tiff');
% signal = imread('./img/fishingboat.jpg');
% signal = imread('./img/brickwall.bmp');
signal = imread('./img/CSF.jpg');
% signal = rgb2gray(signal);

signal = signal(:,:,1);
figure;
imshow(signal);
title('Signal');


k = 1./2*(0.1*pi)^2;
T = 20;
IMF_num = 3;
[IMFs, residual] = conv_emd(signal, k, T, 2, IMF_num, 1, 1, 0.01);


for i = 1:IMF_num
    figure();
    imshow(IMFs(:,:,i));
    % mesh(IMFs(:,:,i));
end

figure();
imshow(IMFs(:,:,i));
% mesh(residual);