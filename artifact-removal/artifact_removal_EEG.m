function [sig_new, D, D_new] = artifact_removal_EEG(sig_us, Fs)
    %% HPF

    %%sig_us = highpass_filter(sig_us,Fs,30,1024);

    %% Do Stationary wavelet decomposition/transform (SWT)

    N = 6;
    data_length = length(sig_us);
    %% zero-padding
    while (mod(data_length, 2^N) ~= 0)
        sig_us(end+1) = 0;
        data_length = length(sig_us);
    end

    sig_us = sig_us(1:data_length) - mean(sig_us(1:data_length));
    sig_new = sig_us;

    wave_name = 'haar' ; 

    %%--SWT

    [A,D] = swt(sig_us,N,wave_name);

    [Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wave_name);%% Remove Artifact Components

    %% Initialization

    length_seizure = length(D);

    window_seizure = 1*Fs; 

    num_seg = floor(length_seizure/window_seizure)-1;

    %% Aprox Coef Thresholding

    A_old = A(end,:); 

    A_new = A_old;

    % k1 = 1;
    D_new = D;

    for j=1:num_seg

        A_segment = A_old(window_seizure*(j)+1:window_seizure*(j)+(window_seizure));

        avg_ratio = max(abs(A_segment));

        thr_ratio = std(A_segment);%sd(A8)
        
        if ( avg_ratio > 2*thr_ratio ) 

            k1 = 0.4;

        elseif ( 2*thr_ratio > avg_ratio > thr_ratio )

            k1 = 0.5;

        else

            k1 = 1; 

        end

    sigma = median(abs(A_segment))/0.6745;

    T = k1*sqrt(2*log10(length(A_segment))*sigma^2);

    id = find((abs(A_segment)> T)==1);
    A_new(id+window_seizure*(j)) = 0;

    %A_new(id+window_seizure*(j)) = 
    T.^2./A_old(id+window_seizure*(j)); 

    end

    %% Detail Coef Thresholding

    for k=1:N
        if(k==4 || k==3 || k==2 || k==6 || k==1)
            
            k2 = 1;

        else

            k2 = 5;

        end

        for j=1:num_seg

             D_segment = D(k, window_seizure*(j)+1:window_seizure*(j)+(window_seizure));

             sigma_sq = median(abs(D_segment))/0.6745;

             Th = k2*sqrt(2*log10(length(D_segment))*sigma_sq^2);

             idx = find((abs(D_segment)> Th)==1);

             D_new(k,idx+window_seizure*(j)) = Th.^2./D(k,idx+window_seizure*(j)); % Garrote 

        end

    end

    %% Reconstruction
    sig_new = sig_us;
    sig_us = iswt(A_new, D_new, Lo_R, Hi_R);

    sig_new = sig_us;
end