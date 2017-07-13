L = 400;
x = linspace(0,6,L);

% signal = 0.5*cos(2*pi*x) + 2*cos(0.1*pi*x) + 0.8*cos(0.5*pi*x);

% ---------------------------------

%ECG data
load('../data/ECG-data/ECG-data');
signal = sig_sample_1';

% ---------------------------------

% % Sine mixture signal 1
% alpha = 0.2;
% f = 20;
% wave_num = pi;
% s1 = sin(wave_num.*x);
% s2 = alpha.*sin(f.*wave_num*x);
% signal = s1 + s2;

% ---------------------------------

% % 2-mode signal mixing
% signal = sin(4*pi.*[x(1:L/2) zeros(1,L/2)] ) + ...
%  sin(24*pi.*[zeros(1,L/2) x(L/2+1:end)]);

% ---------------------------------

% % Infra Sound data
% load('../data/Infra-sound-data/infra-2');
% signal = sample;


k = 1;
T = 0.2;
iter_num = 50;


[IMFs, residule] = conv_emd(signal, k, T, 50, 3);

IMF_num = size(IMFs, 1);
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