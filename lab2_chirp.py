import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy import signal, misc


fs = 8000

t = np.linspace(0, 1/70, 512, endpoint=False)
x0 = signal.chirp(t, 700, 1/70, 900, method='linear')
x1 = signal.chirp(t, 700, 1/70, 9000, method='linear')

fig, ax = plt.subplots(2)

ax[0].plot(t, x0)
ax[1].plot(t, x1)

ax[0].set_title('Time Domain Representation of Chirp Signals')
ax[1].set_xlabel('Time (s)')
ax[0].set_ylabel('(A)', rotation=0, fontsize=15)
ax[1].set_ylabel('(B)', rotation=0, fontsize=15)
plt.show()
