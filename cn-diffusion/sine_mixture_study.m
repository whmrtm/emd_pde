
% Define the mesh in space
t_0 = 0;
<<<<<<< HEAD
t_f = 10.0;
M = 100;
=======
t_f = 5.0;
M = 400;
>>>>>>> da1d1e2524d3e39572cb074eddb01d7558e6a1d1
N = 100;

dx = 2.0/N;
x = 0:dx:2;

x = x';

% define the mesh in time
dt = (t_f-t_0)/M;
t = t_0:dt:t_f;

% define the diffusivity
D = 1/(4*pi.^2);

% define the ratio r
r = D*dt/dx^2


wave_num = 2.0.*pi;
alphas = logspace(-2, 1, 10);
fs = linspace(0, 1, 10);
pms = zeros(10, 10);

s1 = sin(wave_num.*x);

for i = 1:10
    for j = 1:10
        alpha = alphas(i);
        f = fs(j);
        s2 = alpha.*sin(f.*wave_num*x);
        signal = s1 + s2;
<<<<<<< HEAD
        [IMF, residule] = forward_EMD_pde(N, M, D, r, signal, 100, 1);
=======
        [IMF, residule] = forward_EMD_pde(N, M, D, r, signal, 70, 1);
>>>>>>> da1d1e2524d3e39572cb074eddb01d7558e6a1d1
        HFC = IMF(:,1);

        pms(i,j) = norm(HFC - s1) ./ norm(s1);

        fprintf('%i,%i\n',i,j);

    end
end


[myAlpha, myF] = meshgrid(alphas, fs);

figure;
mesh(myAlpha, myF, pms);
set(gca, 'XScale', 'log');
set(get(gca,'XLabel'),'String','alpha');
set(get(gca,'YLabel'),'String','f');
set(get(gca,'ZLabel'),'String','Performance Measure');
zlim([0,1]);
caxis([0,1]);

colorbar();



