clear
clc

%% Construct sampled analog signal and calculate frequency spectrum
% Sampling parameters
Ft = 1000;
Ts = 1/Ft;
t = 0:Ts:1;

% Construct composite inpute signal
xn = zeros(1, length(t));
comp_freqs = [20, 40, 75, 100, 200, 300, 350, 440, 460, 475];
for i = 1:length(comp_freqs)
    temp = sin(2 * pi * comp_freqs(i) * t);
    xn = xn + temp;
end

% Calculate input frequency spectrum
xf = fft(xn);
spectral_len = ceil(length(xf)/2);
xf_trunc = abs(xf(1:spectral_len));
freqs = Ft*(0:spectral_len - 1)/length(xf);

%% Filter specifications
% Lowpass Filter Specifications
Fp_l = 410;
Fs_l = 430;
wp_l = (2 * Fp_l)/Ft;
ws_l = (2 * Fs_l)/Ft;
dp_l = 0.01;
ds_l = 0.1;
Ap_l = -20 * log((1-dp_l)/(1+dp_l));
As_l = -20 * log(ds_l/(1 + dp_l));
[n_l, wp_l] = cheb1ord(wp_l, ws_l, Ap_l, As_l);

% Highpass Filter Specifications
Fp_h = 60;
Fs_h = 40;
wp_h = (2 * Fp_h)/Ft;
ws_h = (2 * Fs_h)/Ft;
Ap_h = 2;
As_h = 50;
dp_h = (1 - 10^(-Ap_h/20))/(1 + 10^(-Ap_h/20));
ds_h = 10^(-As_h/20)*(1 + dp_h);
[n_h, wp_h] = cheb1ord(wp_h, ws_h, Ap_h, As_h);

%% Generate lowpass filter
[z_l, p_l, k_l] = cheby1(n_l, Ap_l, wp_l, 'low');
[lp_filter, gain_l] = zp2sos(z_l, p_l, k_l);

% Calculate impulse response coefficients
[cl, tl] = impz(lp_filter, 50);

% Plot Frequency Response
lpFilt = designfilt('lowpassiir','FilterOrder',n_l, ...
         'PassbandFrequency',Fp_l,'PassbandRipple',Ap_l, ...
         'SampleRate',Ft);
lp_plot = fvtool(lpFilt)

%% Generate highpass filter
[z_h, p_h, k_h] = cheby1(n_h, Ap_h, wp_h, 'high');
[hp_filter, gain_h] = zp2sos(z_h, p_h, k_h);

% Calculate impulse response coefficients
[ch, th] = impz(hp_filter, 50);

%Plot frequency response
hpFilt = designfilt('highpassiir','FilterOrder',n_h, ...
         'PassbandFrequency',Fp_h,'PassbandRipple',Ap_h, ...
         'SampleRate',Ft);
hp_plot = fvtool(hpFilt)

%% Apply Filters to Composite Signal
yn = filtfilt(lp_filter, gain_l, xn);
yn = filtfilt(hp_filter, gain_h, yn);

% Calculate frequency spectrum
yf = fft(yn);
spectral_len = ceil(length(yf)/2);
yf_trunc = abs(yf(1:spectral_len));

%% Plot Results
figure(3)
subplot(2, 1, 1)
plot(t, xn)
title('Input Signal')
xlabel('Time (ms)')
ylabel('Amplitude')
subplot(2, 1, 2)
plot(freqs, xf_trunc)
title('Input Signal Frequency Spectrum')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

figure(4)
subplot(2, 1, 1)
plot(t, yn)
title('Filtered Output Signal')
xlabel('Time (ms)')
ylabel('Amplitude')
ylim([-10 10])
subplot(2, 1, 2)
title('Filtered Output Signal Frequency Spectrum')
plot(freqs, yf_trunc)
xlabel('Frequency (Hz)')
ylabel('Magnitude')

figure(5)
subplot(2, 1, 1)
stem(tl, cl)
title('Impulse Response of Lowpass Filter')
xlabel('Samples')
ylabel('Amplitude')
subplot(2, 1, 2)
stem(th, ch)
title('Impulse Response of Highpass Filter')
xlabel('Samples')
ylabel('Amplitude')
