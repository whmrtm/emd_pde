% k = 1./2*(100*pi)^2;
k = 1./(2*(10*pi)^2);
T = 100;

sigma = sqrt(2*k*T);

signal = imread('./img/wood_texture.jpg');
% signal = imread('./img/texture_1.jpg');

% signal = rgb2gray(signal);
signal = double(signal(:,:,1));

sigma = 1.7;
% window size
sz = 5;
[x,y] = meshgrid(-sz:sz, -sz:sz);
M = size(x,1) - 1;
N = size(y,1) - 1;

Exp_comp = -(x.^2+y.^2)/(2*sigma*sigma);
kernel = exp(Exp_comp)/(2*pi*sigma*sigma);

mean_env = zeros(size(signal));
I = padarray(signal, [sz sz]);

for i = 1:size(I,1) - M
    for j = 1:size(I,2) - N
        temp = I(i:i+M, j:j+M).*kernel;
        mean_env(i,j) = sum(temp(:));
    end
end


% mean_env = uint8(mean_env);

figure;
mesh(signal);
residual = signal - mean_env;

figure;

mesh(mean_env);

figure;
mesh(residual);

