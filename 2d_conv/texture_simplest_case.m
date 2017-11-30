% Generate the signal
img_size = 32;
omega = 0.25*pi;
[X,Y] = meshgrid(1:img_size);
Z = sin(omega.*X).*sin(omega.*Y);
Z = (Z+1)./2;
% Z = mat2gray(Z);
% figure;
% mesh(X,Y,Z);
% figure;

% imshow(Z, []);

signal = Z;


figure;
mesh(signal);
k = 1./(2*(omega)^2);
T = 10;
mean_env = conv_mean_env(signal, k, T);
residual = signal - mean_env;
[zmax,imax,zmin,imin] = extrema2(signal);
[max_i, max_j] = ind2sub(size(signal), imax);
hold on;
scatter3(max_j,max_i,zmax,'filled');

n = length(max_i);
[a,b] = meshgrid(1:n, 1:n);
dmat = sqrt((max_i(a)-max_i(b)).^2 + (max_j(a)-max_j(b)).^2);

dmat(~dmat) = Inf;
shortest_dist = min(dmat(:))
omega = 2*pi./ (sqrt(2)*size(signal,1)./shortest_dist)
k = 1./(2*(omega)^2)


figure;
mesh(mean_env);

figure;
mesh(residual);
