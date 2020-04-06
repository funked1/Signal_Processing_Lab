clear
clc

%% Parts 1 and 2
% Generate the exponential sequence
n = -5:10;
a = 0.5;
x = a.^n;

% Plot the exponential sequence
figure(1);
stem(n, x);
ylabel('Amplitude');
xlabel('Time Index n');
title('Exponential Sequence');

% Compute the DTFT of the exponential sequence using "freqz"
w = linspace(-3*pi, 3*pi, 256);
h = freqz(x, 1, w);

% Plot the frequency domain analysis of x
figure(2);
subplot(2, 2, 1)
plot(w/pi, real(h));
grid;
title('Real Part')
xlabel('\omega/\pi')
ylabel('Amplitude')
subplot(2, 2, 2)
plot(w/pi, imag(h));
grid;
title('Imaginary Part')
xlabel('\omega/\pi');
ylabel('Amplitude');
subplot(2, 2, 3)
plot(w/pi, abs(h));
grid;
title('Magnitude Spectrum')
xlabel('\omega/\pi');
ylabel('Magnitude');
subplot(2, 2, 4)
plot(w/pi, angle(h));
grid;
title('Phase Spectrum')
xlabel('\omega/\pi');
ylabel('Phase, radians');

g = exp(-1i*w*n(1)).*h;

% Plot the frequency response
figure(3);
subplot(2, 2, 1)
plot(w/pi, real(g));
grid;
title('Real Part')
xlabel('\omega/\pi');
ylabel('Amplitude');
subplot(2, 2, 2)
plot(w/pi, imag(g));
grid;
title('Imaginary Part')
xlabel('\omega/\pi');
ylabel('Amplitude');
subplot(2, 2, 3)
plot(w/pi, abs(g));
grid;
title('Magnitude Spectrum')
xlabel('\omega/\pi');
ylabel('Magnitude');
subplot(2, 2, 4)
plot(w/pi, angle(g));
grid;
title('Phase Spectrum');
xlabel('\omega/\pi');
ylabel('Phase, radians');

%% Part 3 - Delayed input signal
D = 5;
m = n + D;
y = a.^m;
h1 = freqz(y, 1, w);

% Plot the exponential sequence
figure(4);
stem(n, y);
ylabel('Amplitude');
xlabel('Time Index n');
title('Exponential Sequence');

% Plot the frequency domain analysis of y
figure(5);
subplot(2, 2, 1)
plot(w/pi, real(h1));
grid;
title('Real Part')
xlabel('\omega/\pi')
ylabel('Amplitude')
subplot(2, 2, 2)
plot(w/pi, imag(h1));
grid;
title('Imaginary Part')
xlabel('\omega/\pi');
ylabel('Amplitude');
subplot(2, 2, 3)
plot(w/pi, abs(h1));
grid;
title('Magnitude Spectrum')
xlabel('\omega/\pi');
ylabel('Magnitude');
subplot(2, 2, 4)
plot(w/pi, angle(h1));
grid;
title('Phase Spectrum')
xlabel('\omega/\pi');
ylabel('Phase, radians');

%% Parts 4 and 5 - Cross-Correlation and Spectral Density
[rxy, l, SD] = ccrs(x, y, 1, 1);

% Plot the cross-correlation sequence
figure(6);
subplot(2, 1, 1)
plot(l, rxy);
grid;
title('Cross-Correlation of x[n] and y[n]')
xlabel('n')
ylabel('x[l]*y[n+l]')

%Plot power spectral density values
subplot(2, 1, 2)
plot(w/pi, real(SD));
grid;
title('Spectral Density of x[n]')
xlabel('\omega/\pi');
ylabel('Power');