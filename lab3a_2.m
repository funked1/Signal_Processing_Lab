clear
clc

%% Continuous Time Domain Specifications
f0 = 20;                        % Hz
Fc = 1000;                      % Samples/second
Tc = 1/ Fc;                     % seconds
StopTime = 1;                   % seconds
tc = (0:Tc:(StopTime - Tc));

xc = cos(2 * pi * f0 * tc);

figure(1);
subplot(3, 1, 1);
plot(tc, xc);
ylim([-2 2]);
title1 = sprintf('Continuous-Time %d Hz Signal', f0);
title(title1);
xlabel('Time (s)');

%% Discrete Time Domain Specifications
Fs = 30;                         % Samples/second
Tn = 1/Fs;                       % seconds
n = (0:Tn:(StopTime - Tn));      % seconds

xn = cos(2 * pi * f0 * n);

figure(1);
subplot(3, 1, 2);
stem(n, xn);
ylim([-2 2]);
title2 = sprintf('Discrete-Time Domain Signal x[n] (fs = %d)', Fs);
title(title2);
xlabel('Time (s)');

%% Reconstructed Continous-Time Signal
N = length(n);
dr = Tn/100;                     % Reconstruct 100x finer than sample rate

index = 1;
len = (StopTime)/dr;
xr = zeros(1, len);              % pre-allocate signal vector
tr = zeros(1, len);              % pre-allocate time vector
for t = 0:dr:(StopTime - dr)
    ht = t:-Tn:t-(N-1)*Tn;
    hr = sinc(ht/Tn);
    
    xr(index) = xn * hr';
    tr(index) = t;
    index = index + 1;
end

figure(1);
subplot(3, 1, 3);
plot(tr, xr);
title('Reconstructed Continuous-Time Signal');
xlabel('Time (s)');

%% Continuous-Time Signal Frequency Analysis
dFc = Fc / length(tc);
f1 = -Fc/2:dFc:Fc/2 - dFc;
Xc = fftshift(fft(xc));

figure(2)
subplot(3, 1, 1);
stem(f1, abs(Xc)/length(tc));
title('Magnitude Spectrum of Continous-Time Signal x(t)');
xlim([-40 40]);
xlabel('Frequency (Hz)');

%% Discrete-Time Signal Frequency Analysis
dFn = Fs / length(n);
f2 = -Fs/2:dFn:Fs/2;
Xn = fftshift(fft(xn, length(f2)));

figure(2);
subplot(3, 1, 2);
plot(f2, abs(Xn)/length(n));
xlim([-40 40])
title3 = sprintf('Magnitude Spectrum of Discrete-Time Signal x[n] (fs = %d)', Fs);
title(title3);
xlabel('Frequency (Hz)')

%% Reconstructed Signal Frequency Analysis
f3 = -len/2:1:len/2;
Xr = fftshift(fft(xr, length(f3)));

figure(2);
subplot(3, 1, 3);
plot(f3, abs(Xr)/len);
xlim([-40 40]);
title('Magnitude Spectrum of Reconstructed Continous-Time Signal x(t)');
xlabel('Frequency (Hz)');
