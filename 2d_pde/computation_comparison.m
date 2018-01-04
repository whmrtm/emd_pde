% Comparison of the computational cost of BEMD and Diffusion-Based EMD


signal = imread('./img/fishingboat.jpg');
signal = double(signal(:,:,1));


%% 
% Parameter Setting
k = 1./2*(0.1*pi)^2;
T = 20;
IMF_num = 3;
iter_num = 100;
fprintf('For Diffusion-based EMD, the computation time is: \n');
tic
[IMFs, residual] = pde_emd(signal, k, T, iter_num, IMF_num, 0, 0, 0.01);
toc

fprintf('For BEMD, the computation time is: \n');`
tic
% IMF = bemd(signal,'FIX',iter_num,'MAXMODES',IMF_num);
IMF = bemd(signal, IMF_num, iter_num);
toc