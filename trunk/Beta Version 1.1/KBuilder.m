function kset = KBuilder(filename, k)
%KBUILDER Summary of this function goes here
%   Detailed explanation goes here
    alphabet = {};
    I = {};
    C = {};
    F = {};
    T = {};
    fd = fopen(filename);
    s = fgetl(fd);
    while (ischar(s))
    %   for i=1:length(positive)
        %s = positive{i,1};
        if length(s) < k
            if isequal(ismember([s], C), [1]) == 0
                C{1,length(C)+1} = s;
            end
        end
        if length(s) >= (k-1)
            if isequal(ismember([s(1:(k-1))], I), [1]) == 0
                I{1,length(I)+1} = s(1:(k-1));
            end
            if isequal(ismember([s((length(s)-k+2):length(s))], F), [1]) == 0               
                F{1,length(F)+1} = s((length(s)-k+2):length(s));
            end
        end
        if length(s) >= k
            for index = 1:(length(s)-k+1)
                if isequal(ismember([s(index:(index+k-1))], T), [1]) == 0
                    T{1,length(T)+1} = s(index:(index+k-1));
                end
            end
        end
        for i = 1:length(s)
            if isequal(ismember([s(i)], alphabet), [1]) == 0
                alphabet{1,length(alphabet)+1} = s(i);
            end
        end
        s = fgetl(fd);
    end
    kset = KSET(alphabet, I, C, F, T);
end


