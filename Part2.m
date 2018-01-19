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
minP = 1;
dP = 1;
maxP = 10;
%Inst values - number of instances
maxInst = 5;


%vectors to loop over
N = minN:dN:maxN;
P = minP:dP:maxP;
W = [10 20 40 80 160];
Inst = 1:maxInst;
Iter = 5:5:25;

% 5D matrix in which we store values
%Number of nodes, probabilities, maxWeight, Iteration, results
values = zeros(length(N), length(P), length(W), length(Inst), length(Iter), 4);

T_time_algo = zeros(length(W), 5);
T_time_sdp = zeros(length(W), 5);

for n = 30
    for p = 5
        for w = 40
            for i = 1:5
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
                    T_time_algo((find(Iter == j)),i) = timeG*j;
                    T_time_sdp((find(Iter == j)),i) = timeSDP;
                end
            end
        end
    end
end
figure(1)
hold on
plot(Iter,mean(T_time_algo(1:length(Iter), :),2)*1000);
hold off
title("Runtime versus T, Goeman")
xlabel('T')
ylabel('Time (ms)')

figure(2)
hold on
plot(Iter,mean(T_time_sdp(1:length(Iter), :),2)*1000);
hold off
title("Runtime versus T, Solver")
xlabel('T')
ylabel('Time (ms)')
% w_time_algo = zeros(length(W), 5);
% w_time_sdp = zeros(length(W), 5);
% 
% for n = 30
%     for p = 5
%         for w = W
%             for i = 1:5
%                 if(p == 10)
%                     filename = "graph\secondpart\maxcut_" + num2str(n) ... 
%                         + "_" + num2str(p) ...
%                         + "_" + num2str(w) ...
%                         + "_instance_0" + num2str(i);
%                 else
%                     filename = "graph\secondpart\maxcut_" + num2str(n) ... 
%                         + "_0" + num2str(p) ...
%                         + "_" + num2str(w) ...
%                         + "_instance_0" + num2str(i);
%                 end
%                 for j = 5
%                     [L,U, timeG, timeSDP] = SDP(filename, j);
%                     w_time_algo((find(W == w)),i) = timeG;
%                     w_time_sdp((find(W == w)),i) = timeSDP;
%                 end
%             end
%         end
%     end
% end
% figure(1)
% hold on
% plot(W,mean(w_time_algo(1:length(W), :),2)*1000);
% hold off
% title("Runtime versus W, Goeman")
% xlabel('W')
% ylabel('Time (ms)')
% 
% figure(2)
% hold on
% plot(W,mean(w_time_sdp(1:length(W), :),2)*1000);
% hold off
% title("Runtime versus W, Solver")
% xlabel('W')
% ylabel('Time (ms)')

% p_time_algo = zeros(length(P), 5);
% p_time_sdp = zeros(length(P), 5);
% 
% for n = 30
%     for p = 5
%         for w = W
%             for i = 1:5
%                 if(p == 10)
%                     filename = "graph\secondpart\maxcut_" + num2str(n) ... 
%                         + "_" + num2str(p) ...
%                         + "_" + num2str(w) ...
%                         + "_instance_0" + num2str(i);
%                 else
%                     filename = "graph\secondpart\maxcut_" + num2str(n) ... 
%                         + "_0" + num2str(p) ...
%                         + "_" + num2str(w) ...
%                         + "_instance_0" + num2str(i);
%                 end
%                 for j = 5
%                     [L,U, timeG, timeSDP] = SDP(filename, j);
%                     p_time_algo((find(P == p)),i) = timeG;
%                     p_time_sdp((find(P == p)),i) = timeSDP;
%                 end
%             end
%         end
%     end
% end
% figure(1)
% hold on
% plot(P*0.1,mean(p_time_algo(1:length(P), :),2)*1000);
% hold off
% title("Runtime versus p, Goeman")
% xlabel('p')
% ylabel('Time (ms)')
% 
% figure(2)
% hold on
% plot(P*0.1,mean(p_time_sdp(1:length(P), :),2)*1000);
% hold off
% title("Runtime versus p, Solver")
% xlabel('p')
% ylabel('Time (ms)')

% n_time_algo = zeros(length(N), 5);
% n_time_sdp = zeros(length(N), 5);
% 
% for n = N
%     for p = 5
%         for w = 40
%             for i = 1:5
%                 if(p == 10)
%                     filename = "graph\secondpart\maxcut_" + num2str(n) ... 
%                         + "_" + num2str(p) ...
%                         + "_" + num2str(w) ...
%                         + "_instance_0" + num2str(i);
%                 else
%                     filename = "graph\secondpart\maxcut_" + num2str(n) ... 
%                         + "_0" + num2str(p) ...
%                         + "_" + num2str(w) ...
%                         + "_instance_0" + num2str(i);
%                 end
%                 for j = 5
%                     n
%                     [L,U, timeG, timeSDP] = SDP(filename, j);
%                     n_time_algo(N(find(N == n),i) = timeG;
%                     n_time_sdp(N(find(N == n),i) = timeSDP;
%                 end
%             end
%         end
%     end
% end
% 
% figure(1)
% hold on
% plot(N,mean(n_time_algo(10:10:70, :)*1000,2));
% hold off
% title("Runtime versus N, Goeman")
% xlabel('N')
% ylabel('Time (ms)')
% text(N, mean(n_time_algo(N,:),2)*1000, num2str(mean(n_time_algo(N, :), 2)*1000));
% 
% figure(2)
% hold on
% plot(N,mean(n_time_sdp(10:10:70, :),2));
% hold off
% title("Runtime versus N, Solver")
% xlabel('N')
% ylabel('Time (s)')
% text(N, mean(n_time_sdp(N,:),2), num2str(mean(n_time_sdp(N, :), 2)));

