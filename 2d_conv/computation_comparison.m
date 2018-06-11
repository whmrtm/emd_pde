% Comparison of the computational cost of BEMD and Diffusion-Based EMD


signal = imread('./img/fishingboat.jpg');
signal = double(signal(:,:,1));


%% 
% Parameter Setting
k = 1./2*(0.1*pi)^2;
T = 20;
iter_num = 100;

for i = 1:8
    IMF_num = i;
    fprintf('%d IMF: For Diffusion-based EMD (conv), the computation time is: \n', i);
    tic
    [IMFs, residual] = conv_emd(signal, k, T, iter_num, IMF_num, 0, 0, 0.01);
    toc

    fprintf('%d IMF: For BEMD, the computation time is: \n', i);
    tic
    % IMF = bemd(signal,'FIX',iter_num,'MAXMODES',IMF_num);
    IMF = bemd(signal, IMF_num, iter_num);
    toc
end