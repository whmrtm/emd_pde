L = 10.0;
fs = 500;
x = linspace(1,L,fs);
Freq = 90;
Period = 10 ./ Freq;
addpath('~/MEGA/Research/EMD/EMD_PDE/tftb/mfiles');

signal = 0.4*sin(2*pi*x / Period);


% fftSignal = fft(signal);
% len = floor(length(fftSignal)./2);
% norm_f = linspace(0, 0.5, len);


% figure;
% plot(norm_f, abs(fftSignal(1:len)),'LineWidth', 2)
% xlabel('Frequency');
% ylabel('Amplitude');




% define analysis parameters
xlen = length(x);                   % length of the signal
wlen = 32;                        % window length (recomended to be power of 2)
hop = wlen/4;                       % hop size (recomended to be power of 2)
nfft = 1024;                        % number of fft points (recomended to be power of 2)

% perform STFT
[S, f, t] = stft(signal, wlen, hop, nfft, fs);

% define the coherent amplification of the window
K = sum(hamming(wlen, 'periodic'))/wlen;

% take the amplitude of fft(x) and scale it, so not to be a
% function of the length of the window and its coherent amplification
S = abs(S)/wlen/K;

% correction of the DC & Nyquist component
if rem(nfft, 2)                     % odd nfft excludes Nyquist point
    S(2:end, :) = S(2:end, :).*2;
else                                % even nfft includes Nyquist point
    S(2:end-1, :) = S(2:end-1, :).*2;
end

% convert amplitude spectrum to dB (min = -120 dB)
% S = 20*log(S + 1e-6);
sum_f = sum(S,2);
sum_f = sum_f ./ max(sum_f);
sum_f = 20*log10(sum_f+1e-6);
f = f ./(2*max(f));
figure;
plot(f, sum_f,'--','LineWidth', 2);
hold on;


% Short time Hilbert Spectrum
[A, ff, tt] = hhspectrum(signal, 1:size(signal,2), 1);
[im, tt] = toimage(A,ff,tt);

% Whole Hilbert Spectrum by accumulation
n_IMF = size(signal,1);
f_bin_num = size(signal,2);
h_f = linspace(0, 1, f_bin_num);
h_f_A = zeros(1, f_bin_num);
err = 1./(f_bin_num-1)./2;

for i = 1:length(tt)
    for j = 1:n_IMF
        for k = 1:f_bin_num
            if abs(h_f(k)-ff(j,i)) < err
                h_f_A(k) = h_f_A(k) + A(j,i);
            end
        end
    end
end
h_f_A = h_f_A ./ max(h_f_A);
h_f_A = 20*log10(h_f_A + 1e-6);
% hold on;

plot(h_f, h_f_A, 'LineWidth', 2);
% xlim([0 0.2])
xlim([0 0.4]);
ylim([-47 0]);
xlabel('Normalized Frequency', 'FontSize', 15);
ylabel('Energy(dB)', 'FontSize', 15);
legend('MFS', 'MHS');
% title('Marginal Hilbert Spectrum and Fourier Spectrum','FontSize', 15);