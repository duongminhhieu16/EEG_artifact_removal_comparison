for i=3:19
    cd D:\EEG\github\mwf-artifact-removal-master\data_emg
    D = dir; 
    currD = D(i).name;
    cd(currD);
    D = dir;
    currD = D(4).name;
    filename = currD;
    [hdr, data_] = edfread(filename);
    sig_new = zeros(size(data_));
    mask = importdata("mask.mat");
    for i=1:14
        data = data_(i, :);
        sig_new(i, :) = data;
        Fs = 250;
        sig = artifact_removal_EEG(data, Fs);
        for j=1:length(mask)
            if mask(j) == 1
                sig_new(i, j) = sig(j);
            end
        end
    end
    save("clean_eeg_swt.mat", "sig_new");
    cd('..')
end