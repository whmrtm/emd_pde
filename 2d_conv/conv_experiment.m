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

% % Signal Plot
% figure;
% subplot(1,IMF_num+2,1);
% imshow(signal);
% title('Original image');
% for i = 1:IMF_num
%     subplot(1,IMF_num+2,i+1)
%     imshow(IMFs(:,:,i));
%     title('IMF');
% end

% subplot(1,IMF_num+2,IMF_num+2);
% imshow(residual);
% title('residual');

for i = 1:IMF_num
    figure();
    mesh(IMFs(:,:,i));
end

figure();
mesh(residual);