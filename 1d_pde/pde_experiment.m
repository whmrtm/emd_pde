
% Define the mesh in space
t_0 = 0;
t_f = 5.0;
M = 50;
N = 400;

dx = 6.0/(N-1);
x = 0:dx:6.0;


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

% ---------------------------------

% 2-mode signal mixing
L = length(x);
signal = sin(4*pi.*[x(1:L/2) zeros(1,L/2)] ) + ...
 sin(24*pi.*[zeros(1,L/2) x(L/2+1:end)]);

% -------------------------------------

% % ECG data
% load('../data/ECG-data/ECG-data');
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

% -------------------------------------



% % Infra Sound data
% load('../data/Infra-sound-data/infra-2');
% signal = sample';

% N = length(signal);
% L = N/50;
% dx = L/(N-1);
% x = 0:dx:L;
% x = x';
% D = 1/(200*pi.^2);
% % define the ratio r
% r = D*dt/dx^2;

% -------------------------------------

% % AM data
% carrier = sin(6*pi.*x);
% am = sin(2*pi*x);
% D = 1/(36*pi.^2);
% signal = (1+ am*2).*carrier;


% -------------------------------------

% FM data
% f_c = 1;
% f_m = 8;
% beta = 0.5;
% signal = cos(2*pi*f_c.*x + beta.*sin(2*pi*f_m.*x));


% -------------------------------------

% Music Signal
load('../data/music-data/piano_sample');
signal = piano_sample';
N = length(signal);
L = N/50;
dx = L/(N-1);
x = 0:dx:L;
% x = x';

% D = 1/(0.0004*pi.^2);
% define the ratio r
% r = D*dt/dx^2;

k = 1./(4*pi).^2;
T = 10;
max_iter = 100;
IMF_num = 3;


[IMFs, residual] = pde_emd(x, signal, k, T, max_iter, IMF_num, 1, 1, 0.01);


% Signal Plot
figure;
subplot(IMF_num+2,1,1);
plot(x, signal, 'LineWidth', 2);
lgd1 = legend('signal');
lgd1.FontSize = 15;

for i = 1:IMF_num
    subplot(IMF_num+2,1,i+1)
    plot(x, IMFs(i,:), 'LineWidth', 2)
end

subplot(IMF_num+2,1,IMF_num+2);
plot(x, residual, 'LineWidth', 2);
ylim([-1,1])
lgd2 = legend('residual');
lgd2.FontSize = 15;


% Combine IMF and residual
myIMF = [IMFs; residual];

% Plot Hilbert Spectrums
plot_hhs(myIMF);

% Plot Fourier Spectrums
% plot_fft(signal);
