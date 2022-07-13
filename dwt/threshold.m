function D = threshold(arr, n, idx)
    D = arr;
    sigma = std(arr);
    mean_ = mean(arr);
    if idx == 6 
        k = 0.7; 
    elseif idx == 4
        k = 1;
    elseif idx == 3
        k = 0.3;
    elseif idx == 2
        k = 0.2;
    else
        k = 0.8;
    end
    thr = k*sqrt(2*log(n))*sigma;
    for i=1:n
        if abs(arr(i)) > thr
            D(i) = 0;
        end
    end
end