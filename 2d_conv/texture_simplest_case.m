% Generate the signal
img_size = 64;
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
[IMFs, residual] = conv_emd(signal, k, T, iter_num, IMF_num, 1, 1, 0.01);


% Window
w = hamming(size(signal, 1));
log_scale = 1;
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
suptitle('Signal');

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
    suptitle(sprintf('IMF %d', i))

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
suptitle('Residual')
