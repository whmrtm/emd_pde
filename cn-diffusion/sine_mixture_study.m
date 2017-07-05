%% sine mixture study regarding alphas and fs
% Define the mesh in space
t_0 = 0;
t_f = 10.0;
M = 100;
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
r = D*dt/dx^2;


wave_num = 2.0.*pi;
alphas = logspace(-2, 2, 100);
fs = linspace(0, 1, 100);
pms = zeros(10, 100);

s1 = sin(wave_num.*x);

for i = 1:100
    for j = 1:100
        alpha = alphas(i);
        f = fs(j);
        s2 = alpha.*sin(f.*wave_num*x);
        signal = s1 + s2;
        [IMF, residule] = forward_EMD_pde(N, M, D, r, signal, 100, 1);
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



%% sine mixture study regarding fs

% % Define the mesh in space
% t_0 = 0;
% t_f = 10.0;
% M = 100;
% N = 100;

% dx = 4.0/N;
% x = 0:dx:2;

% x = x';

% % define the mesh in time
% dt = (t_f-t_0)/M;
% t = t_0:dt:t_f;

% % define the diffusivity
% D = 1/(4*pi.^2);

% % define the ratio r
% r = D*dt/dx^2


% wave_num = 2.0.*pi;
% fs = linspace(0, 1, 100);
% alpha = 1;
% pm = zeros(1,100);
% s1 = sin(wave_num.*x);

% for i = 1:100
%     f = fs(i);
%     s2 = alpha.*sin(f.*wave_num.*x);
%     signal = s1 + s2;
%     [IMF, residule] = forward_EMD_pde(N, M, D, r, signal, 100, 1);
%     HFC = IMF(:,1);
%     pm(i) = norm(IMF - s1) ./ norm(s1);
% end
% plot(fs, pm)