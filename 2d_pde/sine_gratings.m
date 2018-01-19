% Generate the signal
img_size = 128;
omega = 0.1*pi;


[X,Y] = meshgrid(1:img_size);
% Z = sin(omega.*X).*sin(omega.*Y);
Z = sin(omega.*X + omega.*Y) + sin(-4*omega.*X + 8*omega.*Y);


% Convert to 255 scale
Z = (Z+1)./2;
signal = Z*255;

k = 1./2*(0.1*pi)^2;
T = 20;
IMF_num = 1;
iter_num = 100;
[IMFs, residual] = pde_emd(signal, k, T, iter_num, IMF_num, 1, 1, 0.01);

plot_EMD(signal, IMFs, residual);
% plot_EMD_fs(signal, IMFs, residual);