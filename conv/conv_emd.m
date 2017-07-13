function [IMF, residule] = conv_emd(signal, k, T, iter_num, max_IMF)

    L = len(signal);
    signal = sin(2*pi.*x) + 0.5.*sin(0.8*pi.*x);

    k = 1;
    T = 100;
    iter_num = 50;
    max_IMF = 3;


    % Initilize
    curr_signal = signal;

    for j = 1:max_IMF
        for i = 1:iter_num
            [mean_env, gau] = conv_mean_env(r, k, T);
            IMF = r-mean_env;
            if IMF satisfy stop creterion
                break;
            r = IMF;
        end
        IMFs = [IMFs; IMF];
        curr_signal = curr_signal - IMF;
 
        if IMF satisfy stop creterion
            break;

    end

    residule = curr_signal;

end

% Ts = linspace(0,2,20);
% for i = 1:20
%     T = Ts(i);
%     [mean_env, gau] = conv_mean_env(x, signal, k, T);
%     plot(mean_env);
%     hold on;
% end

% plot(signal);
% hold on;
% % plot(gau);
% plot(mean_env);
