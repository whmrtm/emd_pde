
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
D = 1/(24^2*pi.^2);

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
% load('../data/music-data/piano_sample');
% signal = piano_sample';
% N = length(signal);
% L = N/50;
% dx = L/(N-1);
% x = 0:dx:L;
% x = x';
% D = 1/(0.0004*pi.^2);
% define the ratio r
r = D*dt/dx^2;

max_iter = 100;
IMF_num = 1;

[IMF, residule] = forward_EMD_pde(N, M, r, signal, max_iter, IMF_num);
HFC = IMF(1,:);

% pm = norm(HFC - s1) ./ norm(s1);


% plot signal, IMF and residules
figure();
subplot(3,1,1);
plot(x, signal);
ylabel('signal');

subplot(3,1,2);
plot(x, IMF, '-');
ylabel('IMF_1');

subplot(3,1,3);
plot(x, residule, '-');
ylabel('Residule');


% plot the Hilbert spectrum
myIMF = [IMF; residule];
[A, ff, tt] = hhspectrum(myIMF,1:length(myIMF));
[im, tt, ff] = toimage(A,ff);
disp_hhs(im, tt);


