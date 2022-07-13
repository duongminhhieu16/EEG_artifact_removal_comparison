filename = "artifact/tuar/00001006_s001_t001.edf"
[hdr, data_] = edfread(filename);
data = data_(1:13, :);
Fs = 250;
clean_EEG = artifact_removal_EEG(art_eeg(1, :), Fs);
%mask(1:378369) = 0;
%mask(378370:387022) = 1;
%mask(387023:392981) = 0;
%mask(392982:406105) = 1;
%mask(406106:455250) = 0;
%clean_EEG = mwf_process(data, mask, 0);
subplot(2, 1, 1)
plot(art_eeg(1, :))
subplot(2, 1, 2)
plot(clean_EEG)
% for i=1:7
%     figure()
%     hold on
%     subplot(2, 1, 1)
%     plot(data(1, 378370+(i-1)*1250: 378370+i*1250));
%     %set y axis limit
%     if max(data(1, 378370+(i-1)*1250: 378370+i*1250)) > max(clean_EEG(1, 378370+(i-1)*1250: 378370+i*1250))
%         maxx = max(data(1, 378370+(i-1)*1250: 378370+i*1250))
%     else
%         maxx = max(clean_EEG(1, 378370+(i-1)*1250: 378370+i*1250))
%     end
%     if min(data(1, 378370+(i-1)*1250: 378370+i*1250)) < min(clean_EEG(1, 378370+(i-1)*1250: 378370+i*1250))
%         minn = min(data(1, 378370+(i-1)*1250: 378370+i*1250))
%     else
%         minn = min(clean_EEG(1, 378370+(i-1)*1250: 378370+i*1250))
%     end
%     
%     if mod(maxx, 100) > 50
%         maxx = round(maxx, -2);
%     elseif mod(maxx, 100) == 50
%         maxx = round(maxx+1, -2);
%     else
%         maxx = maxx+100-mod(maxx, 100);
%     end
%     if mod(abs(minn), 100) > 50
%         minn = round(minn, -2);
%     elseif mod(abs(minn), 100) == 50
%         minn = -round(abs(minn)+1, -2);
%     elseif mod(abs(minn), 100) < 50
%         minn = -(abs(minn)+100-mod(abs(minn), 100));
%     end
%     ylim([minn maxx])
%     
%     subplot(2, 1, 2)
%     plot(clean_EEG(1, 378370+(i-1)*1250: 378370+i*1250));
%     ylim([minn maxx])
%     hold off
%     %saveas(gcf, "1006_chan1_seg5s_"+ string(i) + ".png")
% end
%auto input