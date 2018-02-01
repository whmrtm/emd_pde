% signal = imread('./img/fishingboat.jpg');
% signal = signal(:,:,1);

sz = [800,800];  %size of image [y,x], in pixels
[x,y]= meshgrid(linspace(1,5,sz(2)),linspace(0,1,sz(1)));
img = sin(exp(x)).*(y.^3);
% img = sin(exp(x));

% img = sin(exp(x)).*(y.^3);
signal = (img+1)*128;


% Generate the signal
% img_size = 128;
% omega = 0.1*pi;


% [X,Y] = meshgrid(1:img_size);
% Z = sin(omega.*X).*sin(omega.*Y);
% Z = sin(omega.*X + omega.*Y) + sin(-4*omega.*X + 8*omega.*Y);



k = 0.4;
T = 100;
mean_env = mean_envelope(signal,k,T);
% image(mean_env);
% colormap(gray(256));