function [y, z] = fft_and_plot(x, L) 
switch nargin
    case 2
        N = length(x);
        if N > L
            msg = 'Error Occurred: length(x) must be less than L';
            error(msg)
        else
            x = x';
            k = L - N;
            x = padarray(x, k, 0, 'post');
        end
    case 1
            x = x';
end
    
    N = length(x);
    y = dftmtx(N)*x;
    z = (conj(dftmtx(N))*y)/N;
end