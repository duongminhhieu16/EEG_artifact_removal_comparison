%input
filename = "D:\EEG\github\mwf-artifact-removal-master\data_emg\s001_2003_04_28\00001006_s001_t001.edf"
[hdr, data_] = edfread(filename);
data = data_(1, :);
Fs = 250    
%artifact removal
[sig_new, D, D_new] = artifact_removal_EEG(data, Fs);
save("D_new_chan1.mat", "D_new");
save("D_old_chan1.mat", "D");
save("D_swt_chan1.mat", "sig_new");
data = data - mean(data);
sig_new = sig_new - mean(sig_new);
hold on
plot(data)
plot(sig_new)
hold off