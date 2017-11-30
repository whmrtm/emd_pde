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

figure(1)
clf
image(img);
colormap(gray(256));
axis equal; axis tight; axis off