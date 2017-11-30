% signal = imread('./img/fishingboat.jpg');
% signal = imread('./img/wood_texture.jpg');
signal = imread('./img/brickwall.bmp');

% signal = rgb2gray(signal);
figure;
surf(signal);

% Find k value for each IMF
[zmax,imax,zmin,imin] = extrema2(signal);
% Use the maximals to estimate k

% zmax = sort(zmax);
% size(zmax)
[max_i, max_j] = ind2sub(size(signal), imax);
hold on;
scatter3(max_j,max_i,zmax,'filled');

n = length(max_i);
[a,b] = meshgrid(1:n, 1:n);
dmat = sqrt((max_i(a)-max_i(b)).^2 + (max_j(a)-max_j(b)).^2);

dmat(~dmat) = Inf;
shortest_dist = min(dmat(:))
omega = 2*pi*size(signal,1)./shortest_dist
k = 1./(2*(omega)^2)
