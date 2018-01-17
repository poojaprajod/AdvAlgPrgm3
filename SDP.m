function [L, U, timeG, timeSDP] = SDP(filename, T)
ops = sdpsettings('solver','sedumi');
% read number of nodes
n = dlmread(filename,'',[0 0 0 0]);
% read the sparse matrix from graph generator
X = dlmread(filename,'',1);
%Graph generator is zero indexed, add 1 to all nodes 
%to prevent this
X(:,[1 2]) = X(:,[1 2]) + 1;
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
timeSDP = sol.solvertime;

%double(A);
% upper bound ?
U = double(-objective);
[L, timeG] = Goeman(objective,A,T,n, W);
end

