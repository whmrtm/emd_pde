function plot_EMD(signal, IMFs, residual)

IMF_num = size(IMFs,3);
% Window
signal = double(signal);
figure;
image(signal);
colormap(gray(256));
axis square;
title('Signal','FontSize',20);

for i = 1:IMF_num
    figure();
    image((IMFs(:,:,i)+126));
    axis square;
    % mesh(IMFs(:,:,i));
    colormap(gray(180));
    title(sprintf('IMF %d', i),'FontSize',20);

end

figure();
image(residual);
colormap(gray(256));
axis square;
title('Residual','FontSize',20);


end