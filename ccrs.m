function [rxy, l, SD] = ccrs(x, y, nx, ny)
    %% shift input signals to index nx and ny
    A = x(nx : length(x));
    B = y(ny : length(y));

    %% determine length of correlation sequence
    len = length(A) + length(B) - 1;
        
    %% time reverse shifted input signal A
    Ar = flip(A);
    
    %% calculate cross correlation sequence values
    rxy = conv(Ar, B);
    
    %% construct index vector
    l = zeros(1, len);
    for i = len:-1:1
        l(i) = i - length(y);
    end
   
    %% compute spectral density  of input signal x
    xr = flip(x);
    rxx = conv(xr, x);
    
    % compute the DTFT of rxx
    w = linspace(-3*pi, 3*pi, 256);
    SD = freqz(rxx, 1, w);
end