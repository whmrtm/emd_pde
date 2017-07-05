
% Define the mesh in space
t_0 = 0;
t_f = 6.0;
M = 100;
N = 400;

dx = 2.0/(N-1);
x = 0:dx:2;

x = x';

% define the mesh in time
dt = (t_f-t_0)/M;
t = t_0:dt:t_f;

% define the diffusivity
D = 1/(4*pi.^2);

% define the ratio r
r = D*dt/dx^2;

% % Sine mixture signal 1
% alpha = 0.2;
% f = 20;
% wave_num = pi;
% s1 = sin(wave_num.*x);
% s2 = alpha.*sin(f.*wave_num*x);
% signal = s1 + s2;


% % Sine mixture signal 2
% signal = 0.5*cos(2*pi*x) + 2*cos(0.1*pi*x) + 0.8*cos(0.5*pi*x);


% % 2-mode signal mixing
% L = length(x);
% signal = sin(4*pi.*[x(1:L/2); zeros(L/2,1)] ) + ...
%  sin(24*pi.*[zeros(L/2,1); x(L/2+1:end)]);

% % ECG data
% load('../ECG-data/ECG-data');
% signal = sig_sample_1;
% L = tm_sample_1(end) - tm_sample_1(1);
% N = length(sig_sample_1);
% dx = L/N;
% x = 0:dx:L;
% x = x';

% % define the mesh in time
% dt = (t_f-t_0)/M;
% t = t_0:dt:t_f;

% % define the diffusivity
% D = 1/(20.^2*pi.^2);

% % define the ratio r
% r = D*dt/dx^2;



max_iter = 50;
IMF_num = 3;


[IMF, residule] = forward_EMD_pde(N, M, D, r, signal, max_iter, IMF_num);
HFC = IMF(:,1);

% pm = norm(HFC - s1) ./ norm(s1);



figure();
subplot(3,1,1);
plot(x, signal);
ylabel('signal');

subplot(3,1,2);
plot(x, HFC, '-o');
ylabel('IMF_1');

subplot(3,1,3);
plot(x, residule, '-*');
ylabel('Residule');



