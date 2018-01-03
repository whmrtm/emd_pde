
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

k = 1./(pi)^2;
T = 10;
IMF_num = 4;
iter_num = 100;

[IMFs, residual] = conv_emd(signal, k, T, iter_num, IMF_num, 1, 2, 0.01);


% Display the data
% Window
w = hamming(size(signal, 1));
log_scale = 0;
figure;
subplot(121)
image(signal);
colormap(gray(256));
subplot(122)
F = fft2(signal.*(w*w'));
if log_scale
    imagesc(log(abs(fftshift(F))));
else
    imagesc(abs(fftshift(F)));
end
% suptitle('Signal');

for i = 1:IMF_num
    figure();
    subplot(121);
    image(IMFs(:,:,i));
    colormap(gray(256));
    subplot(122);
    F = fft2(IMFs(:,:,i).*(w*w'));
    if log_scale
        imagesc(log(abs(fftshift(F))));
    else
        imagesc(abs(fftshift(F)));
    end
    % mesh(IMFs(:,:,i));    
    % suptitle(sprintf('IMF %d', i))

end

figure();
subplot(121)    
image(residual);
colormap(gray(256));
subplot(122)
F = fft2(residual.*(w*w'));
if log_scale
    imagesc(log(abs(fftshift(F))));
else
    imagesc(abs(fftshift(F)));
end
% mesh(residual);
% suptitle('Residual')
