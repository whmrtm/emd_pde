% signal = imread('./lena_gray.tiff');
% signal = imread('moon.tiff');
% signal = imread('./lena512color.tiff');
signal = imread('./fishingboat.jpg');

% mesh(signal);

% k = 1./2*(100*pi)^2;
% T = 20;
% IMF_num = 5;
% [IMFs, residual] = conv_emd(signal, k, T, 200, IMF_num, 1, 1,0.001);

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