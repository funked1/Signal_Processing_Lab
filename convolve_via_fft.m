function z = convolve_via_fft(x, y)
    L = length(x) + length(y) - 1;
    
    [g, m] = fft_and_plot(x, L);
    [h, k] = fft_and_plot(y, L);
    Z = (g .* h);
    
    N = length(Z);
    D = conj(dftmtx(N));
    z = (D * Z)/N;
    z = (abs(z))';
end