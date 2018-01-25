
% Compute Mean Envelope of the given signal 
% 
% [mean_env, gau] = conv_mean_env(x, signal, k, T)
%
% inputs:
%   - x   : x indexes of Signal
%   - signal   : discrete signal
%   - k   : parameter of the diffusion equation u'' = kdu/dt
%   - T : Paramter to control the diffusion time
%
% outputs:
%   - mean_env   : mean envelope of the signal（same length) 
%   - gau   : Gaussian filter generated in the process, for debug purpose
%
%
% Examples:
% x = linspace(0, 1, 100);
% signal = sin(2*pi.*x) + 2.5*sin(0.2*pi.*x);
% k = 1./(4*pi^2);
% T = 10;
% [mean_env, gau] = conv_mean_env(x, signal, k, T);
%
%
% Heming Wang 
% h422wang@uwaterloo.ca

function mean_env = conv_mean_env(signal, k, T)
    sigma = sqrt(2*k*T);
    mean_env = imgaussfilt(signal, sigma);
    
%     mean_env = imgaussfilt(signal, sigma, 'FilterDomain', 'spatial');
    % mean_env = imgaussfilt(signal, sigma, 'FilterSize', 2*ceil(2*sigma)+1, 'FilterDomain', 'frequency');
    
    % N = size(signal, 1);
    % mean_env = conv2(signal, gaussian2d(N,sigma), 'same');
    % mean_env = filter2(signal, gaussian2d(N,sigma), 'same');
end
