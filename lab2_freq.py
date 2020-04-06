import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy import signal, misc
from scipy import fftpack


f0 = 165
f1 = 295
f2 = 575
fs = 8000

t = np.linspace(0, 2, 2 * fs, endpoint=False)
x0 = np.sin(f0 * 2 * np.pi * t)
x1 = np.sin(f1 * 2 * np.pi * t)
x2 = np.sin(f2 * 2 * np.pi * t)
x3 = signal.chirp(t, 700, 2, 900, method='linear')
x4 = x0 + x1 + x2 + x3

X0 = fftpack.fft(x0)
X1 = fftpack.fft(x1)
X2 = fftpack.fft(x2)
X3 = fftpack.fft(x3)
X4 = fftpack.fft(x4)

fig, ax = plt.subplots(5)
freqs = fftpack.fftfreq(len(t)) * fs

ax[0].stem(freqs, np.abs(X0), use_line_collection=True)
ax[0].set_xlim(-fs/8, fs/8)
ax[0].set_ylabel('(A)', rotation=0, fontsize=15)
ax[1].stem(freqs, np.abs(X1), use_line_collection=True)
ax[1].set_xlim(-fs/8, fs/8)
ax[1].set_ylabel('(B)', rotation=0, fontsize=15)
ax[2].stem(freqs, np.abs(X2), use_line_collection=True)
ax[2].set_xlim(-fs/8, fs/8)
ax[2].set_ylabel('(C)', rotation=0, fontsize=15)
ax[3].stem(freqs, np.abs(X3), use_line_collection=  True)
ax[3].set_xlim(-fs/8, fs/8)
ax[3].set_ylabel('(D)', rotation=0, fontsize=15)
ax[4].stem(freqs, np.abs(X4), use_line_collection=True)
ax[4].set_xlim(-fs/8, fs/8)
ax[4].set_ylabel('(E)', rotation=0, fontsize=15)

ax[3].set_xlabel('Frequency in Hertz')
ax[0].set_title('Frequency Domain Representation of Signals')

plt.show()
