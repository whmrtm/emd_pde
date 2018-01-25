signal = imread('./img/texture85.gif');
signal = signal(:,:,1);

% Generate the signal
% img_size = 128;
% omega = 0.1*pi;


% [X,Y] = meshgrid(1:img_size);
% Z = sin(omega.*X).*sin(omega.*Y);
% Z = sin(omega.*X + omega.*Y) + sin(-4*omega.*X + 8*omega.*Y);



k = 0.4;
T = 200;
mean_env = mean_envelope(signal,k,T);
% image(mean_env);
% colormap(gray(256));