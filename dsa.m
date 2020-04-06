    clear
    clc

    %% Import historical data and define sampling and epoch parameters
    [header, recorddata] = edfread('chb01_03.edf');
    Fs = 256;                           % sampling frequency
    T = 1/Fs;                           % sampling period
    N = length(recorddata);             % num samples per channel in record
    channel_num = 10;                   % F4-C4

    % Define epoch paracmeters
    epoch_length  = 10;                 % num seconds per epoch
    sample_length = epoch_length * Fs;  % num samples per epoch
    num_epochs = 30;

    %% Extract data sets from a channel in historical data, subdivide into epochs
    % Non-symptomatic EEG channel data
    % sample start time: 30m00s; end time: 35m:00s
    start = 30 * 60 * Fs;
    stop = (35 * 60 * Fs) - 1 ;
    set_0 = recorddata(channel_num, (start:stop));

    % Symptomatic EEG channel data
    % seizure start time: 50m00s; end time: 50m40s
    start = 48 * 60 * Fs;
    stop = (53 * 60 * Fs) - 1 ;
    set_1 = recorddata(channel_num, (start:stop));

    % Divide sample data into 10 second long epochs
    xt0 = double.empty(0, sample_length);
    xt1 = double.empty(0, sample_length);
    index = 1;
    for i = 1:num_epochs
        for j = 1:sample_length
            xt0(i, j) = set_0(index);
            xt1(i, j) = set_1(index);
            index = index + 1;
        end
    end

    %% Perform FFT on each epoch and store in new matrix
    xf0 = double.empty(0, sample_length);
    xf1 = double.empty(0, sample_length);
    for i = 1:num_epochs
         xf0(i, 1:2560) = fft(xt0(i, 1:2560));
         xf1(i, 1:2560) = fft(xt1(i, 1:2560));
    end
    xf0 = (1/sample_length) .* xf0;
    xf1 = (1/sample_length) .* xf1;

    % Calculate the absolute value of FFT samples
    xf0_real = double.empty(0, sample_length);
    xf1_real = double.empty(0, sample_length);
    for i = 1:num_epochs
        xf0_real(i, 1:2560) = abs(xf0(i, 1:sample_length));
        xf1_real(i, 1:2560) = abs(xf1(i, 1:sample_length));
    end

    % Truncate FFT vectors to only contain one side of the spectrum
    spectal_length = sample_length/2 + 1;
    xf0_trunc = double.empty(0, spectal_length);
    xf1_trunc = double.empty(0, spectal_length);
    for i = 1:num_epochs
        xf0_trunc(i, 1:spectal_length) = xf0_real(i, 1:spectal_length);
        xf1_trunc(i, 1:spectal_length) = xf1_real(i, 1:spectal_length);
    end

    %% Calculate power spectral density
    xf0_trunc = xf0_trunc .^2;
    xf1_trunc = xf1_trunc .^2;

    %% Plot Results
    subplot(1, 2, 1);
    freqs = Fs*(0:(sample_length/2))/sample_length;
    rows = 1:1:num_epochs;
    ticks = 0:4:40;
    mesh(freqs, rows, xf0_trunc)
    xlabel('f (Hz)')
    xlim([0 40])
    xticks(ticks)
    ylabel('Epoch Number')
    ylim([0 30])
    zlabel('Power (pW)')
    title('Power Spectral Density of Non-Symptomatic EEG Data over time')

    subplot(1, 2, 2);
    mesh(freqs, rows, xf1_trunc)
    xlabel('f (Hz)')
    xlim([0 40])
    xticks(ticks)
    ylabel('Epoch Number')
    ylim([0 30])
    zlabel('Power (pW)')
    title('Power Spectral Density of Symptomatic EEG Data over time')
