
% Read Signal from images
signal = imread('./img/fishingboat.jpg');
% signal = imread('./img/brickwall.bmp');
% signal = imread('./img/wood_texture.jpg');
% signal = imread('./img/CSF.jpg');
% signal = rgb2gray(signal);
signal = signal(:,:,1);

% % Generate the sinusoid spatial signal
% img_size = 32;
% omega = 0.25*pi;
% [X,Y] = meshgrid(1:img_size);
% % Z = sin(omega.*X).*sin(omega.*Y);
% Z = sin(omega.*X + omega.*Y);
% Z = (Z+1)./2;
% % Z = mat2gray(Z);
% signal = Z;


figure;
mesh(signal);
[zmax,imax,zmin,imin] = extrema2(signal);
[max_i, max_j] = ind2sub(size(signal), imax);
[min_i, min_j] = ind2sub(size(signal), imin);
hold on;
scatter3(max_j,max_i,zmax,'filled');
scatter3(min_j,min_i,zmin,'filled');

n = length(max_i);
m = length(min_i);
[a,b] = meshgrid(1:n, 1:m);
dmat = sqrt((max_i(a)-min_i(b)).^2 + (max_j(a)-min_j(b)).^2);

dmat(~dmat) = Inf;
[shortest_dist, ind] = min(dmat(:));
[I_A, I_B] = ind2sub(size(dmat),ind);

scatter3(max_j(I_B),max_i(I_B),zmax(I_B),'filled','g');
scatter3(min_j(I_A),min_i(I_A),zmin(I_A),'filled','g');

shortest_dist_y = abs(max_i(I_B)-min_i(I_A))
shortest_dist_x = abs(max_j(I_B)-min_j(I_A))
if shortest_dist_x == 0
    omega = pi ./ shortest_dist_y;
elseif shortest_dist_y == 0
    omega = pi ./ shortest_dist_x;
else
    omega1 = pi./(shortest_dist_x);
    omega2 = pi./(shortest_dist_y);
    omega = sqrt(omega1.^2 + omega2.^2);
end
% k = 1./(omega1^2 + omega2^2)
k = 1./((omega)^2)
T = 20;
mean_env = conv_mean_env(signal, k, T);
residual = signal - mean_env;


figure;
mesh(mean_env);

figure;
mesh(residual);
