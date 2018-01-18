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
maxN = 70;
%P values
minP = 5;
dP = 1;
maxP = 10;
%Inst values - number of instances
maxInst = 5;


%vectors to loop over
N = minN:dN:maxN;
P = minP:dP:maxP;
W = [10 20 40 80 160 320];
Inst = 1:maxInst;
Iter = 10:10:70;

% 5D matrix in which we store values
%Number of nodes, probabilities, maxWeight, Iteration, results
values = zeros(length(N), length(P), length(W), length(Inst), length(Iter), 4);

for n = N
    for p = P
        for w = W
            for i = Inst
                if(p == 10)
                    filename = "graph\secondpart\maxcut_" + num2str(n) ... 
                        + "_" + num2str(p) ...
                        + "_" + num2str(w) ...
                        + "_instance_0" + num2str(i);
                else
                    filename = "graph\secondpart\maxcut_" + num2str(n) ... 
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

time_algo_n = zeros(1, length(N));
time_solver_n = zeros(1, length(N));

for i = 1:length(N)
    time_algo_n(i) = mean(reshape(values(i, 6, 6, :,7, 3), 1, []));
    time_solver_n(i) = mean(reshape(values(i, 6, 6, :,7, 4), 1, []));
end

time_algo_p = zeros(1,length(p));
time_solver_p = zeros(1,length(p));
for i = 1:length(P)
    time_algo_p(i) = mean(reshape(values(:, i, :, :, 1), 1, []));
    time_solver_p(i) = mean(reshape(values(:, i, :, :, 2), 1, []));
end

time_algo_w = zeros(1, length(W));
time_solver_w = zeros(1, length(W));
for i = 1:length(W)
    time_algo_n(i) = mean(reshape(values(:, :, i, :, 1), 1, []));
    time_solver_n(i) = mean(reshape(values(:, :, i, :, 2), 1, []));
end