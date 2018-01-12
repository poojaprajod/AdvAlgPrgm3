function cut_val = sdptest(filename)
ops = sdpsettings('solver','sedumi');
% read number of nodes
n = dlmread(filename,'',[0 0 0 0]);
% read the sparse matrix from graph generator
X = dlmread(filename,'',1);
X = [X;n,n,0];
% convert to a symmetric weight matrix
W = full(spconvert(X));
W = W+W';
% constraints and objective for sdp relaxation
A = sdpvar(n,n);
objective = -trace(W*(ones(n,n)-A))/4;
constraints = [diag(A) == ones(n,1), A >= 0];
% solve sdp relaxation problem
sol = solvesdp(constraints, objective, ops);
%double(A);
% upper bound ?
double(-objective);
sol.solvertime
while 1
    % generate random vector with || r || = 1
    r = randn(n,1);
    r = r/norm(r);
    %vi.r values stored in nx1 vector
    vec = double(A*r);
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