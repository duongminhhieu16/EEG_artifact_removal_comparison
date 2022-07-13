filename = "D:\EEG\github\mwf-artifact-removal-master\data_emg\s001_2003_04_28\clean_eeg_mwf.mat"
clean_eeg = importdata(filename);
len = 140; %140s
Fs = 250;
for idx = 1:20
    art_eeg = eeg;
    mask = zeros([1 len*Fs]);
    for i = 1 : 10
        for j = 1:6
            a = randi(30);
            art_eeg(i, (j-1)*5000+1:j*5000) = art_eeg(i, (j-1)*5000+1:j*5000) + art(a, :);
            mask((j-1)*5000+1:j*5000) = 1;
        end
    end
    save("artifactual_eeg_" + string(idx) + ".mat", "art_eeg")
    save("mask_" + string(idx) + ".mat", "mask")
end