function indice = inflection(x, signal)
    delta_x = x(2) - x(1);
    signal_pp = diff(signal, 2) ./ (delta_x)^2;
    signal_pp = [signal(1) signal_pp signal(end)];
    sig_diff = signal_pp - signal;

    % find exact zero-crossings:
    % ind0 = find(sig_diff == 0);

    % Find approaximate zero-crossings
    ind = find((sig_diff(1:end-1) .* sig_diff(2:end)) < 0);

    % indice = sort([ind0 ind]);
    indice = ind;
end