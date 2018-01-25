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

k = 1./pi^2;
% k = [1./(0.2*pi)^2, 1./(0.4*pi)^2, 1./(0.8*pi)^2];
T = 10; 
IMF_num = 4;
iter_num = 100;
signal = double(signal);
[IMFs, residual] = conv_emd(signal, k, T, iter_num, IMF_num, 1, 2, 0.01);

plot_EMD_fs(signal, IMFs, residual);
