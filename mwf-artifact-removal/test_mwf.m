%input
filename = "C:\Users\ADMIN\Desktop\EEG\Thesis\final\4473_rmbad.edf"
[hdr, data_] = edfread(filename);
data = data_(1:14, :);
%mask to indicates artifacts pos
mask = data_(1, :);
mask(1:378369) = 0;
mask(378370:387022) = 1;
mask(387023:392981) = 0;
mask(392982:406105) = 1;
mask(406106:455000) = 0;
%artifacts removal
[clean_EEG, d] = mwf_process(data, mask, 5);
%save clean eeg
save("C:\Users\ADMIN\Desktop\EEG\Thesis\final\4473_rmbad\clean_eeg_4473.mat", "clean_EEG");
hold on
plot(data(2, :))
plot(clean_EEG(2, :))
hold off