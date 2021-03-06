
% Implement forward-EMD by convolution with Gaussian  
% 
% function [IMFs, residual] = conv_emd(x, signal, k, T, iter_num, max_IMF, stop_criterion, k_finding, threshold)
%
% inputs:
%   - x   : x indexes of Signal
%   - signal   : discrete signal
%   - k   : parameter of the diffusion equation u'' = k du/dt
%   - T : Paramter to control the diffusion time
%   - iter_num : max number iterations for each sifting process, dafault 50
%   - max_IMF : Max number of IMF to find, default 3
%   - stop_criterion : stop criterion, default to be 0.
%   - k_finding : Determine how to find the parameter k, default to be 0.
%   - threshold : Threshold value used to determine stop criterion.
%
% outputs:
%   - IMFs   : Extracted IMFs 
%   - residule   : Residual after applying EMD
%
%
% Examples:
% x = linspace(0, 1, 100);
% signal = sin(2*pi.*x) + 2.5*sin(0.2*pi.*x);
% k = 1./(4*pi^2);
% T = 10;
% [IMFs, residual] = conv_emd(x, signal, k, T);
% [IMFs, residual] = conv_emd(x, signal, k, T, 100, 2, 1, 1);
%
%
% Heming Wang 
% h422wang@uwaterloo.ca

function [IMFs, residual] = pde_emd(x, signal, k, T, iter_num, max_IMF, stop_criterion, k_finding, threshold)

    if nargin < 4 or nargin > ９
        disp('Error');
    elseif nargin < 5
        iter_num = 50;
        max_IMF = 3;
        stop_criterion = 0;
        k_finding = 0;
        threshold = 0.01;
    elseif nargin < 6
        max_IMF = 3;
        stop_criterion = 0;
        k_finding = 0;
        threshold = 0.01;
    elseif nargin < 7
        stop_criterion = 0;
        k_finding = 0;
        threshold = 0.01;
    elseif nargin < 8
        k_finding = 0;
        threshold = 0.01;
    elseif nargin < 9
        threshold = 0.01;
    end

    L = length(signal);
    % k = 1;
    % T = 100;
    % iter_num = 50;
    % max_IMF = 3;
    % thres = 0.01;


    % Initilize
    IMFs = [];
    curr_signal = signal;



    % Check if there is IMF
    if stop_criterion == 2
        [indmin, indmax, indzero] = extr(signal);
        mean_env = mean_envelope(x, signal, k, T);
        cond1 = (abs(length(indmin) + length(indmax) - length(indzero)) < 1);
        % cond2 = ((rms(mean_env)./(rms(signal))).^2 < thres);  
        cond2 = ((rms(mean_env) / rms(signal)).^2) < threshold;
        if cond1 && cond2
            fprintf('No IMF\n');
            max_IMF = 0;
            IMFs = [IMFs; zeros(1, length(signal))];
            residual = signal;
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
            % if mod(i,10) == 0
            %     fprintf(' %i th iterations\n', i);
            % end

            mean_env = mean_envelope(x, r, k, T);
            IMF = r-mean_env;

            % Stop criterion 1
            if stop_criterion == 1 || stop_criterion == 2
                % mean envelope stop criterion
                if (rms(mean_env)/rms(r)).^2 < threshold
                    % fprintf('Meet mean envelope stop criterion stop\n');
                    break;
                end
                % Extremum stop criterion
                % [indmin, indmax, indzero] = extr(r);
                % if abs(length(indmin) + length(indmax) - length(indzero)) < 1
                %     fprintf('Meet extreme number stop criterion stop\n');
                %     break;
                % end
            end

            r = IMF;
        end


        IMFs = [IMFs; IMF];
        curr_signal = curr_signal - IMF;
        % fprintf('--------------------------\n');
 
        % % IMF stop creterion
        % if rms(IMF) < threshold
        %     fprintf('Meet IMF stop criterion stop\n');
        %     break;
        % end

    end

    residual = curr_signal;

end


