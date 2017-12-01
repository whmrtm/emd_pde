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

% figure()
% clf
% image(img);
% colormap(gray(256));
% axis equal; axis tight; axis off

signal = img;

k = 1./2*(0.1*pi)^2;
T = 10;
IMF_num = 5;
iter_num = 200;
[IMFs, residual] = conv_emd(signal, k, T, iter_num, IMF_num, 2, 1, 0.01);


% Display the data
figure;
subplot(121)
image(signal);
colormap(gray(256));
subplot(122)
F = fft2(signal);
imagesc(log(abs(fftshift(F))));
suptitle('Signal');

for i = 1:IMF_num
    figure();
    subplot(121);
    image(IMFs(:,:,i));
    colormap(gray(256));
    subplot(122);
    F = fft2(IMFs(:,:,i));
    imagesc(log(abs(fftshift(F))));
    % mesh(IMFs(:,:,i));    
    suptitle(sprintf('IMF %d', i))

end

figure();
subplot(121)
image(residual);
colormap(gray(256));
subplot(122)
F = fft2(residual);
imagesc(log(abs(fftshift(F))));
% mesh(residual);
suptitle('Residual')
