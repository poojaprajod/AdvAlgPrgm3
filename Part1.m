%Part 1
close all;
clear all;
%W values
minW= 10;
dW = 10;
maxW= 70;
%N values - keep constant for part 1
minN = 10;
dN = 10;
maxN = 10;
%P values
minP = 5;
dP = 5;
maxP = 10;
%Inst values - number of instances
maxInst = 5;
%Iter values - number of times we repeat for the same graph
maxIter = 20;

%vectors to loop over
N = minN:dN:maxN;
P = minP:dP:maxP;
W = [10 20 40 80 160 320 640 1280];
Inst = 1:maxInst;
Iter = 1:maxIter;

% 5D matrix in which we store values
%Number of nodes, probabilities, maxWeight, Iteration, results
values = zeros(length(N), length(P), length(W), length(Inst), length(Iter), 3);

for n = N
    for p = P
        for w = W
            for i = Inst
                if(p == 10)
                    filename = "graph\firstpart\maxcut_" + num2str(n) ... 
                        + "_" + num2str(p) ...
                        + "_" + num2str(w) ...
                        + "_instance_0" + num2str(i);
                else
                    filename = "graph\firstpart\maxcut_" + num2str(n) ... 
                        + "_0" + num2str(p) ...
                        + "_" + num2str(w) ...
                        + "_instance_0" + num2str(i);
                end
                for j = Iter
                    [L, U, time] = sdptest(filename);
                    values(find(N == n), find(P == p), find(W == w), find(Inst == i), find(Iter == j), :) = [L, U, time];
                end
            end
        end
    end
end

%Lower bound Results for n = 10, p = [0.5, 1], W = 10:10:70, I = 1:5

minVal = zeros(2,length(W));
maxVal = zeros(2,length(W));

for i = 1:length(W)
    min1 = inf;
    min2 = inf;
    for j = 1:length(Inst)
        if(min(values(1,1,i,j,:,1))/values(1,1,i,j,1,2) < min1)
            min1 = min(values(1,1,i,j,:,1))/values(1,1,i,j,1,2);
        end
        if(min(values(1,2,i,j,:,1))/values(1,2,i,j,1,2) < min2)
            min2 = min(values(1,2,i,j,:,1))/values(1,2,i,j,1,2);
        end
    end
    minVal(1,i) = min1;
    minVal(2,i) = min2;
end


figure(1)
hold on
semilogy(W, minVal(1,:))
semilogy(W, minVal(2,:))
legend("Lower Bound for p = 0.5", "Lower Bound for p = 1.0")
xlabel("Max Weight")
ylabel("Approximation Ratio")
hold off

