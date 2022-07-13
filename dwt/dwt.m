function dwt = donoho(data)
    art_eeg = data;
    clean_eeg_dwt = zeros([13 455000]);
    for i = 1 : 13
        [c, l] = wavedec(art_eeg(i, :), 6, 'Haar');
        A = appcoef(c, l, 'Haar');
        [D1, D2, D3, D4, D5, D6] = detcoef(c, l, [1 2 3 4 5 6]);
        %donoho threshold
        A_new = threshold(A, length(A), 0);
        D1_new = threshold(D1, length(D1), 1);
        D2_new = threshold(D2, length(D2), 2);
        D3_new = threshold(D3, length(D3), 3);
        D4_new = threshold(D4, length(D4), 4);
        D5_new = threshold(D5, length(D5), 5);
        D6_new = threshold(D6, length(D6), 6);
        %c_new = [A_new D6_new D5_new D4_new D3_new D2_new D1_new];
        c_new = [A_new D6_new D5 D4_new D3_new D2_new D1_new];
        clean_eeg = waverec(c_new, l, 'Haar');
        clean_eeg_dwt(i, :) = clean_eeg(1:455000);
    end
    dwt = clean_eeg_dwt;
end
    %save("tuar/clean_eeg_dwt_donoho.mat", "clean_eeg_dwt");
    % hold on
    % plot(art_eeg(9, :))
    % plot(clean_eeg_dwt(9, :))
    % hold off
