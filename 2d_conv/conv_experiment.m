signal = imread('moon.tif');

k = 1./(10*pi^2);
T = 4;
[IMF, residual] = conv_emd(signal, k, T);