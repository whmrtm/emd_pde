
% classic contrast sensitivity

sz = [800,800];  %size of image [y,x], in pixels
[x,y]= meshgrid(linspace(1,5,sz(2)),linspace(0,1,sz(1)));
img = sin(exp(x)).*(y.^3);
% img = sin(exp(x));

% img = sin(exp(x)).*(y.^3);
img = (img+1)*128;

% figure()
% clf
% image(img);
% colormap(gray(256));
% axis equal; axis tight; axis off

signal = img;

k = 1./(0.2*pi)^2;
T = 10;
IMF_num = 3;
iter_num = 100;

[IMFs, residual] = pde_emd(signal, k, T, iter_num, IMF_num, 1, 2, 0.01);

plot_EMD(signal,IMFs,residual);