function plot_hhs(myIMF)

    % Short time Hilbert Spectrum
    [A, ff, tt] = hhspectrum(myIMF, 1:size(myIMF,2), 1);
    [im, tt] = toimage(A,ff,tt);
    disp_hhs(im, tt, -15);


    % Whole Hilbert Spectrum by accumulation
    n_IMF = size(myIMF,1);
    f_bin_num = size(myIMF,2);
    h_f = linspace(0, 1, f_bin_num);
    h_f_A = zeros(1, f_bin_num);
    err = 1./(f_bin_num-1)./2;

    for i = 1:length(tt)
        for j = 1:n_IMF
            for k = 1:f_bin_num
                if abs(h_f(k)-ff(j,i)) < err
                    h_f_A(k) = h_f_A(k) + A(j,i);
                end
            end
        end
    end

    % h_f_A = h_f_A ./ length(tt);
    figure;
    plot(h_f, h_f_A, 'LineWidth', 2);
    % xlim([0 0.2])
    xlim([0 0.5])
    xlabel('Normalized Frequency', 'FontSize', 15);
    ylabel('Amplitude', 'FontSize', 15);
    title('Hilbert Spectrum','FontSize', 15);
    % set(gca,'LineWidth',2);


    
end