% count number of dataset
cd D:\EEG\github\mwf-artifact-removal-master\data_emg
D = dir; 
num_folder = sum([D(~ismember({D.name},{'.','..'})).isdir])+2;
for i=3:num_folder
    cd D:\EEG\github\mwf-artifact-removal-master\data_emg
    D = dir; 
    currD = D(i).name;
    cd(currD);
    D = dir;
    cnt = 3;
    while true
        currD = D(cnt).name;
        filename = currD;
        [filepath, name, ext] = fileparts(filename);
        if ext == '.edf'
            fprintf(filename)
            fprintf("\n")
            [hdr, data_] = edfread(filename);
            data = data_(1:13, :);
            mask = zeros([1 length(data(1, :))]);
            fprintf("Read data completed.\n")
        elseif ext == '.tse'
            fid = fopen(filename,'rt');
            line_num = 0;
            while true
                line = fgetl(fid);
                if ~ischar(line); break;
                else
                    split_line = split(line);
                    for j=1:size(split_line)
                        if split_line{j,1} == "musc" % where have muscle artifact
                            sp = round(str2double(split_line{j-2,1})*250); %start point in signal
                            ep = round(str2double(split_line{j-1,1})*250); % end point
                            if sp == 0 % if start from 0 -> matlab index from 1
                                sp = sp + 1;
                            end
                            mask(1, sp:ep) = 1;
                            fprintf(sp + " " + ep + " \n");
                        end
                        save("mask.mat", "mask");
                    end
                end  %end of file
                line_num = line_num + 1;   
            end
            fclose(fid);
            break
        end
        cnt = cnt + 1;
    end
    [clean_EEG, d] = mwf_process(data, mask, 5);
    break
    save("clean_eeg_mwf.mat", "clean_EEG");
    cd('..')
end