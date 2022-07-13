filename = "D:\EEG\github\artifact-removal-master\data_emg\s001_2003_04_28\00001006_s001_t001.edf"
[hdr, data_] = edfread(filename);
data = data_(1, :);
Fs = 250;
clean_EEG = artifact_removal_EEG(data, Fs);
clean_EEG_2 = importdata("D:\EEG\github\mwf-artifact-removal-master\ww\clean_eeg.mat");
[hdr1, data_1] = edfread("D:\EEG\github\EEG_preprocessing-master\1006.edf");
clean_EEG_3 = data_1(1, :
%mask(1:378369) = 0;
%mask(378370:387022) = 1;
%mask(387023:392981) = 0;
%mask(392982:406105) = 1;
%mask(406106:455250) = 0;
%clean_EEG = mwf_process(data, mask, 0);
for i=1:1
    figure()
    hold on
    plot(data(1, 378370+(i-1)*500: 378370+i*500));
    %set y axis limit
    if max(data(1, 378370+(i-1)*500: 378370+i*500)) > max(clean_EEG(1, 378370+(i-1)*500: 378370+i*500))
        maxx = max(data(1, 378370+(i-1)*500: 378370+i*500))
    else
        maxx = max(clean_EEG(1, 378370+(i-1)*500: 378370+i*500))
    end
    if min(data(1, 378370+(i-1)*500: 378370+i*500)) < min(clean_EEG(1, 378370+(i-1)*500: 378370+i*500))
        minn = min(data(1, 378370+(i-1)*500: 378370+i*500))
    else
        minn = min(clean_EEG(1, 378370+(i-1)*500: 378370+i*500))
    end
    
    if mod(maxx, 100) > 50
        maxx = round(maxx, -2);
    elseif mod(maxx, 100) == 50
        maxx = round(maxx+1, -2);
    else
        maxx = maxx+100-mod(maxx, 100);
    end
    if mod(abs(minn), 100) > 50
        minn = round(minn, -2);
    elseif mod(abs(minn), 100) == 50
        minn = -round(abs(minn)+1, -2);
    elseif mod(abs(minn), 100) < 50
        minn = -(abs(minn)+100-mod(abs(minn), 100));
    end
    ylim([minn maxx]);
    xlim([0 500]);
    plot(clean_EEG(1, 378370+(i-1)*500: 378370+i*500));
    plot(clean_EEG_2(1, 378370+(i-1)*500: 378370+i*500));
    plot(clean_EEG_3(1, 378370+(i-1)*500: 378370+i*500));
    legend("Contaminated EEG", "Corrected by SWT", "Corrected by MWF", "Corected by ICA", 'Location', 'southeast');
    hold off
    saveas(gcf, "1006_chan1_seg35s_"+ string(i) + "_compared.png")
    break
end
%auto input