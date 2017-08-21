%% Experiment on different signals using convolution implementation

L = 400;
x = linspace(0,6,L);
fs = round(L./x(end));

% %Three sinusoids
% signal = 0.5*cos(2*pi*x) + 2*cos(0.1*pi*x) + 0.8*cos(0.5*pi*x);

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

% 2-mode signal mixing freq 2Hz and 12Hz
signal = sin(4*pi.*[x(1:L/2) zeros(1,L/2)] ) + ...
 sin(24*pi.*[zeros(1,L/2) x(L/2+1:end)]);

% ---------------------------------

% %ECG data
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

% % Music Signal
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

k = 1./(4*pi^2);
T = 20;
iter_num = 100;
IMF_num = 1;

[IMFs, residule] = conv_emd(x, signal, k, T, iter_num, IMF_num, 0, 1);

IMF_num = size(IMFs, 1);
figure;
subplot(IMF_num+2,1,1);
plot(x, signal);
legend('Signal')
for i = 1:IMF_num
    subplot(IMF_num+2,1,i+1)
    plot(x, IMFs(i,:))
end

subplot(IMF_num+2,1,IMF_num+2);
plot(x, residule);
legend('residule')


% plot the Hilbert spectrum
myIMF = [IMFs; residule];
% [A, ff, tt] = hhspectrum(myIMF,1:size(myIMF,2),2,1);
[A, ff, tt] = hhspectrum(myIMF);
[im, tt, ff] = toimage(A,ff);
disp_hhs(im, tt, -20, fs);


% Plot the Short time Fourier Transform
figure;
s = spectrogram(signal);
% spectrogram(signal,'reassigned','yaxis')
spectrogram(signal,'yaxis');