function [lower_bound,time] = Goeman(objective, A, T, n, W)
%Goemans-Williamson algorithm
lower_bound = inf;
tic

%A = double(A) + eye(n)*0.0001;%Avoid negative values close to zero.
%[B,num] = cholcov(A);
[Q, Y] = eig(value(A));
B = double(Q * sqrt(Y));
B = B';

for i = 1:T
    while 1
        % generate random vector with || r || = 1
        r = randn(n,1);
        r = r/norm(r);
        %vi.r values stored in nx1 vector
        vec = double(B'*r);
        % if vi.r >= 0, put node i in S
        S = find(vec >= 0);
        S_dash = find(vec < 0);
        % cut_val = sum of weights of edges across the partitions
        cut_val = sum(sum(W(S,S_dash)));
        % Termination condition
        if cut_val >= 0.878*double(-objective)
            break
        end
    end
    
    if cut_val < lower_bound
        lower_bound = cut_val;
    end
end

time = toc/T
end

