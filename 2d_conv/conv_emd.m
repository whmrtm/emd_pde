
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
        [zmax,imax,zmin,imin] = extrema2(r);
        [max_i, max_j] = ind2sub(size(r), imax);

        n = length(max_i);
        [a,b] = meshgrid(1:n, 1:n);
        dmat = sqrt((max_i(a)-max_i(b)).^2 + (max_j(a)-max_j(b)).^2);
        dmat(~dmat) = Inf;
        shortest_dist = min(dmat(:));
        omega = 2*pi./ (sqrt(2)*size(signal,1)./shortest_dist);
        k = 1./(2*(omega)^2);

    end

    
    for i = 1:iter_num
        if mod(iter_num,20) == 0
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


