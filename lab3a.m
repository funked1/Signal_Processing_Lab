clear
clc

%% Time Specifications:
Fs = 40;                % samples per second
Fc = 1000;              % samples per second
dt = 1/Fs;              % seconds per sample
dtc = 1/Fc;
StopTime = 1;           % seconds
t = (0:dt:StopTime - dt)';
tc = (0:dtc:StopTime-dtc)';
N = size(t, 1);
Nc = size(tc, 1);

%% Sine Wave Defintion:
F0 = 20;                % frequency in Hz
x0 = cos(2*pi*F0*t);
x1 = cos(2*pi*F0*tc);

%% Plot Time-Domain Signals
figure(1);
subplot(3, 1, 1);
plot(tc, x1)
subplot(3, 1, 2);
plot(t, x0)


%% Fourier Transform:
X0 = fftshift(fft(x0));
X1 = fftshift(fft(x1));

%% Frequency Specifications:
dF = Fs/N;
f = -Fs/2:dF:Fs/2 - dF;

dF1 = Fc/Nc;
f1 = -Fc/2:dF1:Fc/2 - dF1;

%% Plot the Magnitude Spectrum:
figure(2);
subplot(3, 1, 1)
plot(f1, abs(X1)/Nc)
xlim([-50 50]);
subplot(3, 1, 2)
plot(f, abs(X0)/N);
xlim([-50 50]);
xlabel('Frequency (Hz)');
title('Magnitude Spectrum');



%%
% f0 = 20;
% fs = 40;
% fcs = 4000;
% 
% t0 = linspace(0, 1, fcs);
% xc = cos(2*pi*f0*t0);
% 
% t1 = 0:1/fs:1-1/fs;
% xn = cos(2*pi*f0*t1);
% 
% N = length(xn);
% T = 1/fs;
% dt = T/100;
% out_idx = 1;
% for t = (-N*T):dt:(N*T*2)
%     ht = t:-T:t-(N-1)*T;
%     hr = sinc(ht/T);
%     
%     xr(out_idx) = xn * hr';
%     xt(out_idx) = t;
%     out_idx = out_idx + 1;
% end
% 
% figure(1)
% subplot(3, 1, 1);
% plot(t0, xc)
% ylim([-2 2]);
% xlabel('Time (s)')
% ylabel('Amplitude')
% title1 = sprintf('Continuous-Time %d Hz Signal', f0);
% title(title1)
% 
% subplot(3, 1, 2);
% stem(t1, xn)
% ylim([-2 2]);
% xlabel('Time (s)')
% ylabel('Amplitude')
% title2 = sprintf('Discrete-Time Sample Sequence with Fs = %d Hz', fs);
% title(title2)
% 
% subplot(3, 1, 3);
% plot(xt, xr)
% xlim([0 1]);
% xlabel('Time (s)')
% ylabel('Amplitude')
% title('Reconstructed Signal')
% 
% 
% %% Magnitude Spectrum
% xcf = fft(xc)/length(xc);
% nc = length(xcf);
% freqc = (-nc/2:nc/2-1) * 0.01;
% 
% 
% %freqz
% % xnf = fft(xn)/length(xn);
% % nn = length(xnf);
% %freqn = (-length(xn)/2:length(xn)/2-1) * fs/length(xn);
% [xnf, w] = freqz(xn, 1, length(xn), 'whole');
% 
% xrf = fft(xr)/length(xr);
% nr = length(xrf);
% freqr = (-nr/2:nr/2 -1) * fs/nr;
% 
% figure(2)
% subplot(3, 1, 1);
% plot (freqc, abs(xcf))
% xlim([-fs fs]);
% subplot(3, 1, 2);
% plot(w, abs(xnf));
% xlim([-fs fs])
% subplot(3, 1, 3);
% plot(freqr, abs(xrf))
% xlim([-fs fs])