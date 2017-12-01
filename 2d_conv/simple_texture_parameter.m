% Generate the signal
img_size = 32;
omega = 0.25*pi;
[X,Y] = meshgrid(1:img_size);
% Z = sin(omega.*X).*sin(omega.*Y);
Z = sin(omega.*X + omega.*Y);
Z = (Z+1)./2;
% Z = mat2gray(Z);
% figure;
% mesh(X,Y,Z);
% figure;

% imshow(Z, []);

signal = Z;


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
% omega = 2*pi./ (sqrt(2)*size(signal,1)./shortest_dist)
omega1 = pi./(2*shortest_dist_x)
omega2 = pi./(2*shortest_dist_y)
k = 1./(omega1^2 + omega2^2)


% k = 1./(2*(omega)^2);
T = 50;
mean_env = conv_mean_env(signal, k, T);
residual = signal - mean_env;


figure;
mesh(mean_env);

figure;
mesh(residual);
