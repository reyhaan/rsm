function R = getResistanceMat(X)
%GETRESISTANCEMAT return the resistance matrix of the graph
%   The resistance between node i and node j is R(i,j)
%   We use the theory derived by D.J Klein and M.randic.
%   D.J. Klein and M. Randic ?, J. Math. Chem. 12, 81(1993).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LP = getLPlus(X);
n = size(X,1);
temp = diag(LP)*ones(1,n);
R = temp + temp' - 2*LP;
end

function L = getLaplacianMat(X)
%GETLAPLACIANMAT(X) The laplacian matrix of the given square matrix
%   X is a generalized adjacent matrix of the graph. The value in the matrix shows the
%   weight of the edges. If the value is zero, then the corresponding edge
%   does not exist.
A = 1./X; % A is the corresponding adjacent matrix of the graph
A(isinf(A))=0;
D = diag(sum(A)); % D is the degree matrix of the graph
L = D-A;
end

function M = getLPlus(S)
%GET Summary of this function goes here
%   Detailed explanation goes here
n = size(S,1);
L = getLaplacianMat(S);
M = inv(L+1/n) - 1/n;
end
