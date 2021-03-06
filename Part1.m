%Part 1
close all;
clear all;
%W values
minW= 10;
dW = 10;
maxW= 70;
%N values - keep constant for part 1
minN = 30;
dN = 10;
maxN = 30;
%P values
minP = 5;
dP = 5;
maxP = 10;
%Inst values - number of instances
maxInst = 5;
%Iter values - number of times we repeat for the same graph
maxIter = 25;

%vectors to loop over
N = minN:dN:maxN;
P = minP:dP:maxP;
W = [10 20 40 80 160 320];


    
Inst = 1:maxInst;
Iter = [25 50 75];

% 5D matrix in which we store values
%Number of nodes, probabilities, maxWeight, Iteration, results
values = zeros(length(N), length(P), length(W), length(Inst), length(Iter), 4);

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
                    [L,U, timeG, timeSDP] = SDP(filename, j);
                    values(find(N == n), find(P == p), find(W == w), find(Inst == i), find(Iter == j),: ) = [L, U, timeG, timeSDP];
                end
            end
        end
    end
end

%Lower bound Results for n = 10, p = [0.5, 1], W = 10:10:70, I = 1:5

minValP05 = zeros(length(Iter), length(W));
minValP1 = zeros(length(Iter), length(W));
for i = 1:length(W)
    for j = 1:length(Inst)
        for k = 1:length(Iter)
            minValP05(k,i) = values(1,1,i,j,k,1)/values(1,1,i,j,1,2);
            minValP1(k,i) = values(1,2,i,j,k,1)/values(1,2,i,j,1,2);
            values(1,2,i,j,k,1)
        end
    end
end


figure(1)
for i = 1:length(Iter)
hold on
plot(W, minValP05(i,:))
hold off
end
title("Lower Bound Goeman-Williamson vs N = 30, Max Weight, p = .5, various T")
legend("Lower Bound for T = " + Iter)
xlabel("Max Weight")
ylabel("\alpha")

figure(2)
for i = 1:length(Iter)
hold on
plot(W, minValP1(i,:))
hold off
end
title("Lower Bound Goeman-Williamson vs N = 30, Max Weight, p = 1, various T")
legend("Lower Bound for T = " + Iter)
xlabel("Max Weight")
ylabel("\alpha")







