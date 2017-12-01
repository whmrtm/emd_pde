
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

function [IMFs, residual] = conv_emd(signal, k, T, iter_num, max_IMF, stop_criterion, k_finding, threshold)


if nargin < 3 or nargin > 8
    disp('Error');
elseif nargin < 4
    iter_num = 50;
    max_IMF = 3;
    stop_criterion = 0;
    k_finding = 0;
    threshold = 0.01;
elseif nargin < 5
    max_IMF = 3;
    stop_criterion = 0;
    k_finding = 0;
    threshold = 0.01;
elseif nargin < 6
    stop_criterion = 0;
    k_finding = 0;
    threshold = 0.01;
elseif nargin < 7
    k_finding = 0;
    threshold = 0.01;
elseif nargin < 8
    threshold = 0.01;
end


% Initilize
IMFs = [];
curr_signal = signal;




% The significant part of this 2d method is to redefine the IMF 
% Find some references first

for j = 1:max_IMF

    % fprintf('Calculating the %i IMF\n', j);
    r = curr_signal;

    if k_finding == 1
        % Find k value for each IMF
        [zmax,imax,zmin,imin] = extrema2(signal);
        [max_i, max_j] = ind2sub(size(signal), imax);
        [min_i, min_j] = ind2sub(size(signal), imin);

        n = length(max_i); m = length(min_i);
        [a,b] = meshgrid(1:n, 1:m);
        dmat = sqrt((max_i(a)-min_i(b)).^2 + (max_j(a)-min_j(b)).^2);
        dmat(~dmat) = Inf;
        [shortest_dist, ind] = min(dmat(:));
        [I_A, I_B] = ind2sub(size(dmat),ind);
        shortest_dist_y = abs(max_i(I_B)-min_i(I_A));
        shortest_dist_x = abs(max_j(I_B)-min_j(I_A));
        if shortest_dist_x == 0
            omega1 = 0;
        else
            omega1 = pi./(2*shortest_dist_x);
        end

        if shortest_dist_y == 0
            omega2 = 0;
        else
            omega2 = pi./(2*shortest_dist_y);
        end
        k = 1./(omega1^2 + omega2^2)

    end

    
    for i = 1:iter_num
        if mod(i,20) == 0
            fprintf(' %i th iterations\n', i);
        end
        mean_env = conv_mean_env(r, k, T);
        IMF = r-mean_env;

        % Stop criterion 1
        if stop_criterion == 1 || stop_criterion == 2
            % mean envelope stop criterion
            if (rms(mean_env)./rms(r)) < threshold
                fprintf('Meet mean envelope stop criterion stop\n');
                break;
            end
            % % Extremum stop criterion
            % [indmin, indmax, indzero] = extr(r);
            % if abs(length(indmin) + length(indmax) - length(indzero)) < 1
            %     fprintf('Meet extreme number stop criterion stop\n');
            %     break;
            % end
        end

        r = IMF;
    end


    IMFs = cat(3,IMFs, IMF);
    curr_signal = curr_signal - IMF;

    fprintf('--------------------------\n');
    % IMF stop creterion
    % if rms(IMF)./rms(signal) < threshold
    %     fprintf('Meet IMF stop criterion stop\n');
    %     break;
    % end

end

residual = curr_signal;

end


