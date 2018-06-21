
% Parameter Setting
% k = 1./2*(0.1*pi)^2;
k = 1./(12^2*pi^2);
T = 10;
iter_num = 200;
IMF_num = 8;
load('../data/music-data/piano_sample');
signal = piano_sample';
L = length(signal);
x = linspace(0, round(L/200), L);
fs = x./L;


for i = 1:IMF_num
    % IMF_num = i;
    % fprintf('%d IMF: For Diffusion-based EMD (PDE), the computation time is: \n', i);
    % tic
    % [IMFs, residual] = pde_emd(signal, k, T, iter_num, IMF_num, 0, 0, 0.01);
    % toc   

    fprintf('%d IMFs: For Diffusion-based EMD (conv), the computation time is: \n', i);
    tic
    [IMFs, residual] = conv_emd(x, signal, k, T, iter_num, i, 1, 1, 0.01);
    toc


    fprintf('%d IMF: For EMD, the computation time is: \n', i);
    tic
    IMF = emd(signal,'FIX',iter_num,'MAXMODES',i);
    % IMF = emd(signal, IMF_num, iter_num);
    toc
end