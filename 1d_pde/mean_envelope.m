
% Compute Mean Envelope of the given signal 
% 
% [mean_env] = mean_envelope(x, signal, k, T)
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
% [mean_env] = mean_envelope(x, signal, k, T);
%
%
% Heming Wang 
% h422wang@uwaterloo.ca

function [mean_env] = mean_envelope(x, signal, k, T)

    L = x(end);
    N = length(x);
    r = 1./4;
    M = fix(k*N^2*T ./ (r*L^2));

    mean_env = heat_fd(x,signal,T,k,L,M,N);

end
