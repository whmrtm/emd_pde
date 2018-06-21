%% Experiment on different signals using convolution implementation

% Some initialization
L = 600;
x = linspace(0,6,L);
fs = round(L./x(end));
addpath('~/MEGA/Research/EMD/EMD_PDE/tftb/mfiles');


%Three sinusoids
% signal = 0.5*cos(20*pi*x) + 2*cos(8*pi*x) + 0.8*cos(0.5*pi*x);

% ---------------------------------

% % Chirp signal
% signal = chirp(x, 20, 1, 60, 'quadratic');


% ---------------------------------

% % Sine mixture signal 1
% alpha = 0.2;
% f = 20;
% wave_num = pi;
% s1 = sin(wave_num.*x);
% s2 = alpha.*sin(f.*wave_num*x);
% signal = s1 + s2;

% ---------------------------------

% % 2-mode signal mixing freq 2Hz and 12Hz
% signal = sin(4*pi.*[x(1:L/2) zeros(1,L/2)] ) + ...
%  sin(24*pi.*[zeros(1,L/2) x(L/2+1:end)]);

% signal = sin(15*pi.*[x(1:L/2) zeros(1,L/2)] ) + ...
%  sin(24*pi.*[zeros(1,L/2) x(L/2+1:end)]);

% signal = sin(12*pi.*[x(1:L/2) zeros(1,L/2)] ) + ...
%  sin(9*pi.*[zeros(1,L/2) x(L/2+1:end)]);

% signal = 0.6*sin(4*pi.*[x(1:L/2) zeros(1,L/2)] ) + ...
%  sin(24*pi.*[zeros(1,L/2) x(L/2+1:end)]);

% signal = 100*sin(12*pi.*[x(1:L/2) zeros(1,L/2)] ) + ...
%  sin(24*pi.*[zeros(1,L/2) x(L/2+1:end)]);

% signal = sin(4*pi.*x) + sin(24*pi.*[zeros(1,L/4) x(L/4+1:L/2) zeros(L/2+1:end)]);
signal = sin(4*pi.*x) + sin(24*pi.*[zeros(1,L/4) x(L/4+1:end)]);



% ---------------------------------

%ECG data
% load('../data/ECG-data/ECG-data');
% signal = sig_sample_1';
% L = length(signal);
% x = linspace(0,6,L);

% ---------------------------------

% % Infra Sound data
% load('../data/Infra-sound-data/infra-2');
% signal = sample;
% L = length(signal);
% x = linspace(0, round(L/50), L);
% fs = 50;

% -------------------------------------

% % AM data
% carrier = sin(6*pi.*x);
% am = sin(2*pi*x);
% D = 1/(36*pi.^2);
% signal = (1+ am*2).*carrier;


% -------------------------------------

% % FM data
% f_c = 1;
% f_m = 8;
% beta = 0.5;
% signal = cos(2*pi*f_c.*x + beta.*sin(2*pi*f_m.*x));


% -------------------------------------

% Music Signal
% load('../data/music-data/piano_sample');
% signal = piano_sample';

% load('../data/music-data/oboe');
% signal = oboe_sample';

% load('../data/music-data/flute');
% signal = flute_sample';

% load('../data/music-data/bendir');
% signal = bendir_sample';

% L = length(signal);
% x = linspace(0, round(L/200), L);
% fs = x./L;



% % -------------------------------------
% % Triangular + sinusoid waveform (nonlinear case)

% N = 1024;% # of data samples
% x = 1:N;

% % triangular waveform 1
% p1 = fix(N/6);% period
% x1 = triangular_signal(N,p1);

% % tone
% f0 = 0.03;% frequency
% x2 = real(fmconst(N,f0));

% % triangular waveform 2
% p3 = 5;% period
% x3 = triangular_signal(N,p3);

% signal = x1 + 0.4*x2' + .4*x3;


k = 1./(6^2*pi^2);
T = 20;
% T = 15;
iter_num = 500;
IMF_num = 2;

[IMFs, residual] = conv_emd(x, signal, k, T, iter_num, IMF_num, 1, 1, 0.01);

IMF_num = size(IMFs, 1);

% Signal Plot
figure;
subplot(IMF_num+2,1,1);
plot(x, signal, 'LineWidth', 1.5);
lgd1 = legend('signal');
lgd1.FontSize = 15;

for i = 1:IMF_num
    subplot(IMF_num+2,1,i+1)
    plot(x, IMFs(i,:), 'LineWidth', 1.5)
end

subplot(IMF_num+2,1,IMF_num+2);
plot(x, residual, 'LineWidth', 1.5);
ylim([-1,1])
lgd2 = legend('residual');
lgd2.FontSize = 15;


% Combine IMF and residual
myIMF = [IMFs; residual];

% Plot Hilbert Spectrums
plot_hhs(myIMF);

% Plot Fourier Spectrums
plot_fft(signal);
