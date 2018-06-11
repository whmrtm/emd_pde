function plot_EMD_fs(signal, IMFs, residual)
IMF_num = size(IMFs,3)
% Window
w = hamming(size(signal, 1));
signal = double(signal);
log_scale = 0;
figure();
image(signal);
title('Signal')
% mesh(signal);
axis square;
colormap(gray(256));
figure();
F = fft2(signal.*(w*w'));
if log_scale
    imagesc(log(abs(fftshift(F))));
    title('Fourier Spectrum (log scale) of signal');
else
    imagesc(abs(fftshift(F)));
    title('Fourier Spectrum of signal');
end
axis square;

for i = 1:IMF_num
    figure();
    image(IMFs(:,:,i)+126);
    axis square;
    % mesh(IMFs(:,:,i));
    colormap(gray(256));
    title(sprintf('IMF %d', i))
    figure();
    F = fft2(IMFs(:,:,i).*(w*w'));
    if log_scale
        imagesc(log(abs(fftshift(F))));
        title(sprintf('Fourier Spectrum (log scale) of IMF %d', i))
    else
        imagesc(abs(fftshift(F)));
        title(sprintf('Fourier Spectrum of IMF %d', i))
    end
    axis square;

end

figure();
image(residual);
axis square;
% mesh(residual);
colormap(gray(256));
title('Residual')
figure();
F = fft2(residual.*(w*w'));
if log_scale
    imagesc(log(abs(fftshift(F))));
    title('Fourier Spectrum (log scale) of residual')
else
    imagesc(abs(fftshift(F)));
    title('Fourier Spectrum of residual')
end
axis square;


end 