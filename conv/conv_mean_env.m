function [mean_env, gau] = conv_mean_env(x, signal, k, T)
    L = length(signal);
    
    % % Gaussian filter
    % gau = zeros(1, L);
    % if x(end) < 6*delta
    %     fprintf('Bad values for delta');
    % end
    % gau = 1./sqrt(4*pi*k*T).*exp( - (x).^2 ./(4*k*T) );
    % gau = gau ./ norm(gau);
    % norm(gau)

    % Build Gaussian filter
    sigma = sqrt(2*k*T);
    c = x(end)/2;
    gau = exp(-(x-c) .^ 2 / (2 * sigma ^ 2));
    gau = gau./sum(gau);


    % gau = gaussmf(x, [sigma c]);

    % alpha = (L-1) ./ sqrt(8*k*T);

    % halfbandwidth = round(L./2);
    mean_env = conv(signal, gau,'same');

    
    % mean_env = cconv(signal, gau, L);

    % mean_env = mean_env(halfbandwidth: end-halfbandwidth);

    % % Try Median Filter
    % mean_env = medfilt1(signal, 3);

    % figure();
    % subplot(2,1,1);
    % plot(signal);
    % hold on;
    % plot(mean_env);
    % legend('signal', 'mean');

    % subplot(2,1,2);
    % plot(gau);
    % legend('Gaussian');

end
