import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy import signal, misc
from scipy import fftpack


f1 = 165
f2 = 295
f3 = 575
fs = 8000

t = np.linspace(0, 1/f1, 512, endpoint=False)
x0 = np.sin(f1 * 2 * np.pi * t)
x1 = np.sin(f2 * 2 * np.pi * t)
x2 = np.sin(f3 * 2 * np.pi * t)
x3 = signal.chirp(t, 700, 1/f1, 900, method='linear')

signals = [x0, x1, x2, x3]

fig, ax = plt.subplots(4)
for i in range(4):
    ax[i].plot(t, signals[i])

ax[0].set_title('Time Domain Representation of Signals')
ax[3].set_xlabel('Time (s)')
ax[0].set_ylabel('(A)', rotation=0, fontsize=15)
ax[1].set_ylabel('(B)', rotation=0, fontsize=15)
ax[2].set_ylabel('(C)', rotation=0, fontsize=15)
ax[3].set_ylabel('(D)', rotation=0, fontsize=15)
plt.show()
