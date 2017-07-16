function [IMFs, residule] = conv_emd(x, signal, k, T, iter_num, max_IMF)

    L = length(signal);
    % k = 1;
    % T = 100;
    % iter_num = 50;
    % max_IMF = 3;


    % Initilize
    IMFs = [];
    curr_signal = signal;

    for j = 1:max_IMF
        % fprintf('Calculating the %i IMF\n', j);
        r = curr_signal;
        for i = 1:iter_num
            % fprintf(' %i th iterations\n', i);
            [mean_env, gau] = conv_mean_env(x, r, k, T);
            IMF = r-mean_env;
            % mean envelope stop creterion
            if rms(mean_env) < 0.01
                % fprintf('Meet mean envelope stop criterion stop\n');
                break;
            end
            r = IMF;
        end
        IMFs = [IMFs; IMF];
        curr_signal = curr_signal - IMF;
        % fprintf('--------------------------\n');
 
        % IMF stop creterion
        if rms(IMF) < 0.01
            % fprintf('Meet IMF stop criterion stop\n');
            break;
        end

    end

    residule = curr_signal;

end


