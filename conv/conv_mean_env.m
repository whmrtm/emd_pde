function [mean_env, gau] = conv_mean_env(signal, k, T)
    
    L = length(signal);
    
    delta = sqrt(2*k*T);
    % % Gaussian filter
    % gau = zeros(1, L);
    % if x(end) < 6*delta
    %     fprintf('Bad values for delta');
    % end
    % gau = 1./sqrt(4*pi*k*T).*exp( - (x).^2 ./(4*k*T) );
    % gau = gau ./ norm(gau);
    % norm(gau)

    alpha = (L-1) ./ sqrt(8*k*T);
    gau = gausswin(L, alpha);
    gau = gau./sum(gau);

    mean_env = conv(signal, gau, 'same');

    % halfbandwidth = round(L./2);
    % mean_env = conv(signal, gau);
    % mean_env = mean_env(halfbandwidth: end-halfbandwidth);


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
