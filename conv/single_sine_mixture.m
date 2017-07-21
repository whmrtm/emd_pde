%% sine mixture study regarding alphas and fs
L = 400;
x = linspace(0,10,L);

% define the diffusivity
k = 1/(4*pi.^2);
% k = 1;

wave_num = 2.0.*pi;
s1 = sin(wave_num.*x);
T = 10;


alpha = 90;
f = 0.8;
s2 = alpha.*sin(f.*wave_num*x);
signal = s1 + s2;


[IMFs, residule] = conv_emd(x, signal, k, T, 100, 1);

HFC = IMFs(1,:);
pm = norm(HFC - s1) ./ norm(s1)

[mean_env, gau] = conv_mean_env(x, signal, k, T);

figure();
subplot(311);
plot(x, signal);
hold on;
plot(x, mean_env);
plot(x, s1);
ylabel('signal');

subplot(312);
plot(x, HFC);
ylabel('HFC');

subplot(313);
plot(x, residule);
ylabel('residue');