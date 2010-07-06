% Author: Hasan Ibne Akram, Huang Xiao
% Munich University of Technology
% Web: http://www.sec.in.tum.de/hasan-akram/
% Email: hasan.akram@sec.in.tum.de
%          huang.xiao@mytum.de
% Copyright © 2010
% 
% This is a beta version
% 
% DISCLAIMER OF WARRANTY
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
% Here defines the data structure of DFA

classdef DFA

    % This class deinfes the DFA structure
    properties
    
        FiniteSetOfStates   % FiniteSetOfStates is the set of finite states donated as Q
        Alphabets   % the set of alphabets
        TransitionMatrix  % the state transition matrix. 'X' is denoted as no transition
        InitialState   % the set of initial states
        FinalAcceptStates   % the set of final accepting states
        FinalRejectStates  % the rejecting states
        
        % Optional propoerties, needed in case of implmenting RPNI version
        % of Colin de la Higuera, http://labh-curien.univ-st-etienne.fr/~cdlh/book/
        
        RED % set of all the red states
        BLUE % set of all the blue states
        
    end
    
    methods
%        % contructor
%        function obj = DFA(q, a, tm, i, fa, fr)
%             obj.FiniteSetOfStates = q;
%             obj.Alphabets = a;
%             obj.TransitionMatrix = tm;
%             obj.InitialState = i;
%             obj.FinalAcceptStates = fa;
%             obj.FinalRejectStates = fr;           
%        end
        
       % This constructor is needed in case of implmenting RPNI version
       % of Colin de la Higuera, http://labh-curien.univ-st-etienne.fr/~cdlh/book/
       
       function obj = DFA(q, a, tm, i, fa, fr, red, blue)
            obj.FiniteSetOfStates = q;
            obj.Alphabets = a;
            obj.TransitionMatrix = tm;
            obj.InitialState = i;
            obj.FinalAcceptStates = fa;
            obj.FinalRejectStates = fr;  
            obj.RED = red;
            obj.BLUE = blue;
       end
        
    end
end

