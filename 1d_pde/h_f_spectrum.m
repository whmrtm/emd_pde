[A, ff, tt] = hhspectrum(myIMF, 1:size(myIMF,2), 5);
% [im, tt, ff] = toimage(A,ff, tt);
% disp_hhs(im, tt, -20);
n_IMF = size(myIMF,1);

f_bin_num = 600;
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
h_f_A = h_f_A ./ length(tt);

plot(h_f, h_f_A);
