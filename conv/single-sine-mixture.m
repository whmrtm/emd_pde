%% sine mixture study regarding alphas and fs
L = 400;
x = linspace(0,6,L);

% define the diffusivity
% k = 1/(4*pi.^2);
k = 1;

wave_num = 2.0.*pi;
s1 = sin(wave_num.*x);
T = 200.0;


alpha = 1.2;
f = 0.4;
s2 = alpha.*sin(f.*wave_num*x);
signal = s1 + s2;


[IMFs, residule] = conv_emd(signal, k, T, 100, 1);
HFC = IMFs(1,:);
pm = norm(HFC - s1) ./ norm(s1)

figure();
subplot(311);
plot(x, signal);

subplot(312);
plot(x, HFC);

subplot(313);
plot(x, residule);
