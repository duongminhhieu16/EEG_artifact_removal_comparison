import pyedflib
from collections import defaultdict
import numpy as np
from scipy import signal
from matplotlib import pyplot as plt
from matplotlib import mlab
import scipy.io as sio
import math
triang_250 = signal.get_window("triang", 250)

# label, for example: pos1[0]-pos2[0] is montage 0
pos1 = ["EEG FP1-LE", "EEG F7-LE", "EEG T3-LE", "EEG T5-LE", "EEG FP2-LE", "EEG F8-LE", "EEG T4-LE",
        "EEG T6-LE", "EEG A1-LE", "EEG T3-LE", "EEG C3-LE", "EEG CZ-LE", "EEG C4-LE", "EEG T4-LE",
        "EEG FP1-LE", "EEG F3-LE", "EEG C3-LE", "EEG P3-LE", "EEG FP2-LE", "EEG F4-LE", "EEG C4-LE", "EEG P4-LE"]
pos2 = ["EEG F7-LE", "EEG T3-LE", "EEG T5-LE", "EEG O1-LE", "EEG F8-LE", "EEG T4-LE", "EEG T6-LE",
        "EEG O2-LE", "EEG T3-LE", "EEG C3-LE", "EEG CZ-LE", "EEG C4-LE", "EEG T4-LE", "EEG A2-LE",
        "EEG F3-LE", "EEG C3-LE", "EEG P3-LE", "EEG O1-LE", "EEG F4-LE", "EEG C4-LE", "EEG P4-LE", "EEG O2-LE"]
def save_fig(signal, file_name):
    #Pxx, freq = plt.psd(signal, Fs=250)
    #p = []
    #idx = 0
    #for val in Pxx:
    #    if idx >= 390*250 & idx <= 392*250:
    #        p.append(10*math.log(val, 10))
    #    idx = idx + 1
    #print(p)
    #plt.plot(p)
    #print(len(Pxx))
    #plt.savefig(file_name)
    plt.plot(signal)
    plt.show()

if __name__ == "__main__":
##    s = sio.loadmat('D:/EEG/github/artifact-removal-master/data_emg/s001_2003_04_28/1006_new_1.mat')['sig_new']
    #f, pxx = signal.welch(s[0], 128, nperseg=128)
##    D = sio.loadmat('D_old_chan1.mat')['D']
##    D_new = sio.loadmat('D_new_chan1.mat')['D_new']
##    j = 0
##    k = 0
##    fig1, ax1 = plt.subplots(2, 3)
##    for i in D:
##        ax1[k, j].plot(i)
##        j = j + 1
##        if j == 3:
##            k = 1
##            j = 0
##    k = 0
##    j = 0
##    fig2, ax2 = plt.subplots(2, 3)
##    for i in D_new:
##        ax2[k, j].plot(i)
##        j = j + 1
##        if j == 3:
##            k = 1
##            j = 0
##    plt.show()
    #print(len(s[0]))
    #print("Mat data: " + str(pxx1-pxx))
    f = pyedflib.EdfReader("D:/EEG/github/EEG_preprocessing-master/1006.edf")
    n = f.signals_in_file
    signal_labels = f.getSignalLabels()
    sampling_freq = f.getSampleFrequencies()[0] # freq = 250
    print("Sampling frequency: " + str(sampling_freq))
    print("Signal labels: " + str(signal_labels))
    print("There are " + str(len(signal_labels)) + " channels")
    # n signals
    sigbufs = np.zeros((n, f.getNSamples()[0]))
    # montage = {0,..., 21}
    # patient_num
    # patient_num = 3849
    # montage = 7
    for i in np.arange(n):
        sigbufs[i, :] = f.readSignal(i)
    data = sigbufs[0, :]
    data_ = data - np.mean(data)
    plt.figure(1)
    plt.plot(data)
    plt.figure(2)
    plt.plot(data_)
    plt.show()
##    for i in range(6):
##        plt.figure()
##        plt.plot(data[(1571+i*10)*250:(1571+(i+1)*10)*250])
##    plt.show()
    #data = sigbufs[4, :]
    #plt.psd(data, 250, Fs=250)
    #pxx1, f1 = plt.psd(s[0], 250, Fs=250)
    #plt.show()
