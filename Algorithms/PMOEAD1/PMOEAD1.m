function PMOEAD1(Global)
% <algorithm> <H-N>
% PMOEA/D1: A Multiobjective Evolutionary Algorithm Based on Decomposition
% kind --- 1 --- The type of aggregation function

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    kind = Global.ParameterSet(1);

    %% Generate the weight vectors
    [W,Global.N] = UniformPoint(Global.N,Global.M);
    T = ceil(Global.N/10);

    %% Detect the neighbours of each solution
    B = pdist2(W,W);
    [~,B] = sort(B,2);
    B = B(:,1:T);
    
    %% Generate random population
    Population = Global.Initialization();
    Z = min(Population.objs,[],1);

    %% Optimization
    while Global.NotTermination(Population)
%         Population1 = Population;
%         Population2 = Population;
        num = fix(Global.N/3);
        
        sliced(:,1) = Population;
        for i = 1:3
            Z_ = Z;
            B_ = B;
            W_ = W;
            T_ = T;
            Global_ = Global;
            Pop = Population;
            sliced(:,i) = Optimization(Global_,Pop, Z_, B_, W_, T_, i, num ,kind);
        end
        temp = sliced(:,1)';
        Population(1:num) = temp(1:num);
        temp = sliced(:,2)';
        Population(num+1:2*num) = temp(num+1:2*num);
        temp = sliced(:,3)';
        Population(2*num+1:3*num) = temp(2*num+1:3*num);
    end
end
