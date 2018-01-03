signal = imread('./img/fishingboat.jpg');
signal = signal(:,:,1);
mean_env = mean_envelope(signal,0.1,50);
image(mean_env);
colormap(gray(256));