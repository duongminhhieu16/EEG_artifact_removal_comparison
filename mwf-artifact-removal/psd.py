import pyedflib
from collections import defaultdict
import numpy as np
from scipy import signal
from matplotlib import pyplot as plt
import scipy.io as sio
import math
from matplotlib.mlab import psd
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
####    s = sio.loadmat('D_chan1.mat')['D']
####    for i in range(8):
####        plt.figure(i)
####        plt.psd(s[i], 250, Fs=250)
####        name = "D_" + str(i) + ".png"
####        plt.savefig(name)
####    plt.legend(["D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8"], loc ="lower right")
##    s1 = sio.loadmat('D_swt_chan1.mat')['sig_new']
##    s2 = sio.loadmat('clean_EEG.mat')['clean_EEG'] #mwf
####    clean = sio.loadmat('D:/Complete_EEG_classify/Clean Data/DOAN-L01.mat')['data']
####    s4 = sio.loadmat('D:/Complete_EEG_classify/1 WORKING/DOAN/L/DOAN-L01.mat')['x2']
####    print(clean)
######    #f, pxx = signal.welch(s[0], 128, nperseg=128)
######    
######    #print(len(s[0]))
######    #print("Mat data: " + str(pxx1-pxx))
    f = pyedflib.EdfReader("00001006_s001_t001.edf")
    n = f.signals_in_file
    signal_labels = f.getSignalLabels()
    sampling_freq = f.getSampleFrequencies()[0] # freq = 250
    print("Sampling frequency: " + str(sampling_freq))
    print("Signal labels: " + str(signal_labels))
    print("There are " + str(len(signal_labels)) + " channels")
##    
######    for i in range(6):
######        plt.figure()
######        plt.plot(s[0][(1571+i*10)*250:(1571+(i+1)*10)*250])
######        plt.savefig("mwf_1006_seg" + str(i+5) + "_new_1.png")
####    # n signals
##    sigbufs = np.zeros((n, f.getNSamples()[0]))
####    # montage = {0,..., 21}
####    # patient_num
####    # patient_num = 3849
####    # montage = 7
##    for i in np.arange(n):
##        sigbufs[i, :] = f.readSignal(i)
##    data = sigbufs[0, :]
##    data_clean_mwf = s2[0]
##    data_clean_swt = s1[0][0:455250]
####    emg = data_clean - data
##    f = pyedflib.EdfReader("clean_eeg_ica.edf")
##    n = f.signals_in_file
##    sigbufs1 = np.zeros((n, f.getNSamples()[0]))
##    for i in np.arange(n):
##        sigbufs1[i, :] = f.readSignal(i)
##    data_clean_ica = sigbufs1[0, :]
##    data = data-np.mean(data)
##    data_clean_mwf = data_clean_mwf-np.mean(data_clean_mwf)
##    data_clean_ica = data_clean_ica-np.mean(data_clean_ica)
##    plt.plot(data[1515*250:1519*250])
##    plt.plot(data_clean_swt[1515*250:1519*250])
##    plt.plot(data_clean_mwf[1515*250:1519*250])
##    plt.plot(data_clean_ica[1515*250:1519*250])
####    pxx, a = plt.psd(data, 250, Fs=250)
####    pxx_swt, aaa = plt.psd(data_clean_swt, 250, Fs=250)
####    pxx_mwf, aa = plt.psd(data_clean_mwf, 250, Fs=250)
####    pxx_ica, aaaa = plt.psd(data_clean_ica, 250, Fs=250)
####    pxx_mat_clean, a1 = psd(clean[0], 250, Fs=250)#
####    pxx_mat, a1 = psd(s4[0], 250, Fs=250)#
####    x2 = pxx_mat_clean
####    pxx = pxx_mat
####    # Frequency Correlation
####    coef = np.corrcoef(clean[0], s4[0])
####    cx1 = coef[0][0]
####    cx2 = coef[0][1]
####    print(cx2)
####    fc = []
####    for i in range(len(a)):
####        numer = 0
####        sum1 = 0
####        sum2 = 0
####        deno = 0
####        if i == len(a)-1:
####            numer = numer+cx1*x2[i]+cx2*pxx[i]
####            sum1 = sum1+cx1*pxx[i]
####            sum2 = sum2+cx2*x2[i]
####            deno = math.sqrt(sum1*sum2)
####        elif i < len(a)-1:
####            n = 2
####            if i == len(a)-2:
####                n = 1
####            for j in range(n):
####                numer = numer+cx1*x2[i+j]+cx2*pxx[i+j]
####                sum1 = sum1+cx1*pxx[i+j]
####                sum2 = sum2+cx2*x2[i+j]
####            deno = math.sqrt(sum1*sum2)
####        ss = 1/2 * (numer/deno)
####        if i == 0:
####            ss = ss / 2
####        fc.append(ss)
####    max_ = max(fc)
####    for i in range(len(a)):
####        fc[i] = fc[i]/max_
####    markerline, stemlines, baseline = plt.stem(fc, markerfmt='D', bottom=0.0)
####    
####    markerline.set_markerfacecolor('none')
####    plt.plot(data)
####    plt.plot(data_clean) #mwf
####    plt.plot(s1[0][1513*250:1518*250]) #swt
####    plt.plot(s3) #ica
####    for i in range(6):
####        plt.figure()
####        plt.plot(data[(1571+i*10)*250:(1571+(i+1)*10)*250])
####        plt.savefig("mwf_1006_seg" + str(i+5) + "_old_1.png")
####
####    plt.psd(data, 250, Fs=250)
####    plt.psd(data_clean, 250, Fs=250)
####    plt.psd(emg, 250, Fs=250)
####    plt.psd(s2[0], 250, Fs=250)
####    plt.psd(s3, 250, Fs=250)
##    plt.legend(["Contaminated EEG", "Corrected by SWT", "Corrected by MWF", "Corrected by ICA"], loc ="lower right") 
##    plt.show()
