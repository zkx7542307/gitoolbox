% [Authors]: Hasan Ibne Akram, Huang Xiao
% [Institute]: Munich University of Technology
% [Web]: http://code.google.com/p/gitoolbox/
% [Emails]: hasan.akram@sec.in.tum.de, huang.xiao@mytum.de
% Copyright © 2010
% 
% ****** This is a beta version ****** 
% [DISCLAIMER OF WARRANTY]
% This source code is provided "as is" and without warranties
% as to performance or merchantability. The author and/or 
% distributors of this source code may have made statements 
% about this source code. Any such statements do not constitute 
% warranties and shall not be relied on by the user in deciding
% whether to use this source code. 
% 
% This source code is provided without any express or implied
% warranties whatsoever. Because of the diversity of conditions
% and hardware under which this source code may be used, no
% warranty of fitness for a particular purpose is offered. The 
% user is advised to test the source code thoroughly before relying
% on it. The user must assume the entire risk of using the source code.
% 
% -------------------------------------------------
% [Description]
% Building frequency prefix tree acceptor with respect to samples
% Only used for Alergia
% Input: A set of samples
% Output: Deterministic Frequency Finite Automaton (DFFA).
%         A sorted training set.
%         Total number of samples.

function [dffa, training_set_sorted, numOfSamples] = Build_FPTA(filename)
%BUILD_FPTA builds FPTA from samples
    % first column denotes states, second column denotes corresponding final
    % state frequency
    training_set_sorted = {};
    SetOfStates = [1];    
    A = {};
    Init_Stat_Freq = [];
    Final_Stat_Freq = [];
    % first matrix denotes associate transition matrix, second denotes
    % corresponding frequency
    Freq_Tran_Matrix = {[],[]};
    Asso_Tran_Matrix = [];
    
    fid = fopen(filename, 'r');
    if (fid < 0)
        error('Could not open file');
    end
    
    s = fgetl(fid);
    numOfSamples = 0;
    % creating alphabets list
    while (ischar(s))
        % increase initial state frequency indicating how many samples we
        % have in total.
        numOfSamples = numOfSamples + 1;
        
        % insert into training_set_sorted
        k = length(training_set_sorted);
        training_set_sorted{k+1, 1} = s;
        k = k + 1;
        if (k > 1)
            len = k;
            % insertion sort
            while ((len > 1) && (LEXICALCMP(training_set_sorted{len-1, 1}, training_set_sorted{len, 1})==1))
                temp = training_set_sorted{len-1, 1};
                training_set_sorted{len-1, 1} = training_set_sorted{len, 1};
                training_set_sorted{len, 1} = temp;
                len = len - 1;
            end
        end
        % start parsing alphabets
        for i = 1:length(s)
            if(isempty(A))
                A{1} = s(i); 
            end
            if(~max(strcmp(A, s(i))))
                A{length(A)+1} = s(i);
            end
        end
        s = fgetl(fid);
    end
    % set initial state frequency
    Init_Stat_Freq = [numOfSamples];
    % All come in, all go out (final frequency for initial state)
    Final_Stat_Freq = [0];
    
    % begin building prefix tree acceptor
    prefixes = {''};
    for i = 1:length(training_set_sorted)
        str = training_set_sorted{i, 1};       
        for j = 1:length(str)
            if(~max(strcmp(str(1:j), prefixes)))
                prefixes{length(prefixes)+1, 1} = str(1:j);
                SetOfStates = [SetOfStates; (length(SetOfStates) +1)];
                Init_Stat_Freq = [Init_Stat_Freq; 0];
                Final_Stat_Freq = [Final_Stat_Freq;0];
                % initialization
                Freq_Tran_Matrix{1}(length(SetOfStates), 1:length(A)) = 0;
                Freq_Tran_Matrix{2}(length(SetOfStates), 1:length(A)) = 0;                               
            end
            transit_state_from = find(strcmp(prefixes, str(1:j-1)));
            alphabet_index = find(strcmp(A, str(j)));
            transit_state_to = find(strcmp(prefixes, str(1:j)));
            Freq_Tran_Matrix{1}(transit_state_from, alphabet_index) = transit_state_to;
            Freq_Tran_Matrix{2}(transit_state_from, alphabet_index) = Freq_Tran_Matrix{2}(transit_state_from, alphabet_index) + 1;
        end
        Final_Stat_Freq(find(strcmp(str, prefixes))) = Final_Stat_Freq(find(strcmp(str, prefixes))) + 1;
    end
    dffa = DFFA(SetOfStates, A, Init_Stat_Freq, Final_Stat_Freq, Freq_Tran_Matrix, Freq_Tran_Matrix{1}, [], []);
    %dffa = AlergiaStochasticMerge(dffa, 6, 2);
end



