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
[shortest_dist, ind] = min(dmat(:));
[I_A, I_B] = ind2sub(size(dmat),ind);

scatter3(max_j(I_A),max_i(I_A),zmax(I_A),'filled','r');
scatter3(max_j(I_B),max_i(I_B),zmax(I_B),'filled','r');


% omega = 2*pi./ (sqrt(2)*size(signal,1)./shortest_dist)
omega1 = 2*pi*(size(signal,1)./shortest_dist_x)
omega2 = 2*pi*(size(signal,1)./shortest_dist_y)
k = 1./(omega1^2 + omega2^2)


figure;
mesh(mean_env);

figure;
mesh(residual);
