function [mean_env, gau] = conv_mean_env(x, signal, T)
    L = length(x);
    delta = sqrt(2.*T);
    % Gaussian filter
    mid_point = x(round(L/2));
    new_x = linspace(mid_point-3*delta, mid_point+3*delta, 6*delta/x(end).*L);
    gau = 1./sqrt(4*pi*T).*exp( - (new_x - mid_point).^2 ./(4.*T) );
    gau = gau ./ norm(gau);
    norm(gau)
    mean_env = cconv(signal, gau, L);


    figure();
    subplot(2,1,1);
    plot(signal);
    hold on;
    plot(mean_env);
    subplot(2,1,2);
    plot(gau);

end
