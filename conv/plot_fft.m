function plot_fft(signal)
    % Plot the Short time Fourier Transform
    figure;
    s = spectrogram(signal);
    Nx = length(signal);
    nsc = round(Nx./10);
    overlap = round(nsc ./ 2);
    nfft = max(256, 2^nextpow2(nsc)); 
    spectrogram(signal,hann(nsc), overlap, nfft ,'yaxis')
    title('Short time Fourier Transform');
    xlabel('Time');
    ylabel('Frequency');
    % spectrogram(signal,'yaxis');

    % Plot the Fourier Spectrum
    % Am I using the same way to do Fourier spectrum compared with HIlbert?

    fftSignal = fft(signal);
    len = floor(length(fftSignal)./2);
    norm_f = linspace(0, 0.5, len);
    figure;
    plot(norm_f, abs(fftSignal(1:len)))
    title('Fourier analysis');
    xlabel('Frequency');
    ylabel('Amplitude');

end