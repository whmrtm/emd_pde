function plot_EMD_fs(signal, IMFs, residual)
IMF_num = size(IMFs,3)
% Window
w = hamming(size(signal, 1));
signal = double(signal);
log_scale = 0;
figure;
subplot(121)
image(signal);
% mesh(signal);
axis square;
colormap(gray(256));
subplot(122)
F = fft2(signal.*(w*w'));
if log_scale
    imagesc(log(abs(fftshift(F))));
else
    imagesc(abs(fftshift(F)));
end
axis square;
% suptitle('Signal');

for i = 1:IMF_num
    figure();
    subplot(121);
    image(IMFs(:,:,i)+126);
%     axis square;
    % mesh(IMFs(:,:,i));
    colormap(gray(256));
    subplot(122);
    F = fft2(IMFs(:,:,i).*(w*w'));
    if log_scale
        imagesc(log(abs(fftshift(F))));
    else
        imagesc(abs(fftshift(F)));
    end
%     axis square;
%     suptitle(sprintf('Convolution-generated IMF %d', i))

end

figure();
subplot(121)
image(residual);
% axis square;
% mesh(residual);
colormap(gray(256));
subplot(122)
F = fft2(residual.*(w*w'));
if log_scale
    imagesc(log(abs(fftshift(F))));
else
    imagesc(abs(fftshift(F)));
end
% axis square;

% suptitle('Convolution-generated Residual')

end 