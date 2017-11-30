%MakeCSF.m
%
%Matlab code to generate the classic contrast sensitivity figure in which
%spatial frequency increases (exponentially) from left to right. 
%Contrast increases from top to bottom. The boundary between the invisible and 
%visible gratings is shaped like the human CSF (contrast sensitivity function).
%
%Note, however, that the apparent contrast of the bottom of the image (high
%contrast) appears roughly equal across spatial frequencies - a
%demonstration of 'contrast constancy'.
%
%Written by G.M. Boynton, August 2005

sz = [800,800];  %size of image [y,x], in pixels

[x,y]= meshgrid(linspace(1,5,sz(2)),linspace(0,1,sz(1)));

img = sin(exp(x)).*(y.^3);
img = (img+1)*128;

figure()
clf
image(img);
colormap(gray(256));
axis equal; axis tight; axis off


k = 1./2*(0.1*pi)^2;
T = 20;
IMF_num = 2;
[IMFs, residual] = conv_emd(img, k, T, 2, IMF_num, 1, 1, 0.01);


for i = 1:IMF_num
    figure();
    % imshow(IMFs(:,:,i));
    mesh(IMFs(:,:,i));
    colormap(gray(256));
    axis equal; axis tight; axis off
end

figure();
% imshow(IMFs(:,:,i));
mesh(residual);
colormap(gray(256));
axis equal; axis tight; axis off

