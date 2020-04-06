clear
clc

%% Time Specifications:
Fs = 100;
dt = 1/Fs;
StopTime = 1;
t = (0:dt:StopTime - dt)';
N = size(t, 1);

%% Sine Wave:
Fc = 12;
x = cos(2 * pi * Fc * t);

%% Fourier Transform:
X = fftshift(fft(x));

%% Frequency Specifications
dF = Fs/N;
f = -Fs/2:dF:Fs/2-dF;

%% Plot the spectrum:
figure;
plot(f, abs(X)/N);
xlabel('Frequency (Hz)');
title('Magnitude Response');