function [IMFs, residule] = conv_emd(x, signal, k, T, iter_num, max_IMF, stop_criterion, k_finding)

    if nargin < 4 or nargin > 8
        disp('Error');
    elseif nargin < 5
        iter_num = 50;
        max_IMF = 3;
        stop_criterion = 0;
        k_finding = 0;
    elseif nargin < 6
        max_IMF = 3;
        stop_criterion = 0;
        k_finding = 0;
    elseif nargin < 7
        stop_criterion = 0;
        k_finding = 0;
    elseif nargin < 8
        k_finding = 0;
    end

    L = length(signal);
    % k = 1;
    % T = 100;
    % iter_num = 50;
    % max_IMF = 3;


    % Initilize
    IMFs = [];
    curr_signal = signal;

    thres = 0.01;


    % Check if there is IMF
    if stop_criterion == 2
        [indmin, indmax, indzero] = extr(signal);
        [mean_env, gau] = conv_mean_env(x, signal, k, T);
        cond1 = (abs(length(indmin) + length(indmax) - length(indzero)) < 1);
        % cond2 = ((rms(mean_env)./(rms(signal))).^2 < thres);  
        cond2 = ((rms(mean_env) / rms(signal)).^2) < thres;
        if cond1 && cond2
            fprintf('No IMF\n');
            max_IMF = 0;
            IMFs = [IMFs; zeros(1, length(signal))];
            residule = signal;
        end
    end
    
    for j = 1:max_IMF

        % fprintf('Calculating the %i IMF\n', j);
        r = curr_signal;

        if k_finding == 1
            % Find k value for each IMF
            [indmin, indmax, indzero] = extr(r);
            min_dist = min(diff(indmax)) * (x(end)./length(x));
            k = 1./(2*pi./min_dist).^2;

            if isempty(k)
                k = 1./(4*pi^2);
            end
        end

        
        for i = 1:iter_num
            % fprintf(' %i th iterations\n', i);
            [mean_env, gau] = conv_mean_env(x, r, k, T);
            IMF = r-mean_env;

            % Stop criterion 1
            if stop_criterion == 1
                % mean envelope stop criterion
                if (rms(mean_env)/rms(r)).^2 < thres
                    fprintf('Meet mean envelope stop criterion stop\n');
                    break;
                end
                % Extremum stop criterion
                [indmin, indmax, indzero] = extr(r);
                if abs(length(indmin) + length(indmax) - length(indzero)) < 1
                    fprintf('Meet extreme number stop criterion stop\n');
                    break;
                end
            end

            r = IMF;
        end


        IMFs = [IMFs; IMF];
        curr_signal = curr_signal - IMF;
        % fprintf('--------------------------\n');
 
        % IMF stop creterion
        if rms(IMF) < thres
            % fprintf('Meet IMF stop criterion stop\n');
            break;
        end

    end

    residule = curr_signal;

end


