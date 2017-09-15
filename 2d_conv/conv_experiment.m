% signal = imread('./lena_gray.tiff');
% signal = imread('moon.tiff');
signal = imread('./lena512color.tiff');

k = 1./(4*pi^2);
T = 500;
IMF_num = 2;
[IMFs, residual] = conv_emd(signal, k, T, 2, IMF_num);

% Signal Plot
figure;
subplot(1,IMF_num+2,1);
imshow(signal);
title('Original image');
for i = 1:IMF_num
    subplot(1,IMF_num+2,i+1)
    imshow(IMFs(:,:,i));
    title('IMF');
end

subplot(1,IMF_num+2,IMF_num+2);
imshow(residual);
title('residual');