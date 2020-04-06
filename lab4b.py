import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy.fftpack import fft
from scipy import signal

# Function to plot frequency response
def plot_response(fs, w, h, title):
    "Utility function to plot response functions"
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.plot(0.5*fs*w/np.pi, 20*np.log10(np.abs(h)))
    ax.set_ylim(-40, 5)
    ax.set_xlim(0, 0.5*fs)
    ax.grid(True)
    ax.set_xlabel('Frequency (Hz)')
    ax.set_ylabel('Gain (dB)')
    ax.set_title(title)

# Define sampling parameters
Fs = 8500       # sampling frequency in Hz
T = 1.0/Fs      # sampling period
N = 1024        # number of samples
t = np.linspace(0.0, N*T, N)

# Define component signal attributes
A = [2, 7, 12]        # component signal amplitudes
F = [60, 175, 900]    # component signal frequencys in Hz

# Convert Hz to radians/sec
w = []
for i in range(len(F)):
    omega = F[i] * 2 * np.pi
    w.append(omega)

# Generate component and composite signals
x0 = A[0] * np.sin(w[0]*t)
x1 = A[1] * np.cos(w[1]*t)
x2 = A[2] * np.sin(w[2]*t)
xt = x0 + x1 + x2

# Construct multi-band FIR filter w/following parameters:
# 101-order filter
# Band 1: Amplitude=1, F1=0, F2=100, Weighted Ripple=1
# Band 2: Amplitude=0, F1=175,F2=4250, Weighted Ripple=1
filter_order = 101
fir_coeff = signal.firls(filter_order,
                         [0.0, 100.0, 175.0, 4250.0],
                         [1.0, 1.0, 0.0, 0.0],
                         weight=[1, 1], fs=Fs)

# Filter input signal xt using FIR filter
yt = signal.lfilter(fir_coeff, [1], xt)

# Compute fft of input and output signals
Xf = fft(xt)
Yf = fft(yt)
freqs = np.linspace(0.0, 1.0/(2.0*T), N//2)

# Plot time domain signals xt and yt
fig, ax = plt.subplots(2)
#ax[0].grid(True)
#ax[0].plot(t, xt)
#ax[0].set_xlabel('Time (s)')
#ax[0].set_ylabel('Amplitude')
#ax[0].set_title('Input Signal x(t)')
#ax[1].plot(t, yt)
#ax[1].set_xlabel('Time (s)')
#ax[1].set_ylabel('Amplitude')
#ax[1].set_title('Filtered Signal y(t)')

# Plot frequency domain magnitude spectrums of Xf and Yf
#ax[0].plot(freqs, 2.0/N * np.abs(Xf[0:N//2]))
#ax[0].set_xlabel('Frequency (Hz)')
#ax[0].set_ylabel('Magnitude')
#ax[0].set_title('Magnitude Spectrum of X(f)')
#ax[1].plot(freqs, 2.0/N * np.abs(Yf[0:N//2]))
#ax[1].set_xlabel('Frequency (Hz)')
#ax[1].set_title('Magnitude Spectrum of Y(f)')
#ax[1].set_ylabel('Magnitude')

plt.grid()
plt.show()

# Compute and plot the frequency response of the filter
w, h = signal.freqz(fir_coeff, [1], worN=2000)
plot_response(Fs, w, h, "Impulse Response of Multi-Band FIR Filter")
plt.show()
