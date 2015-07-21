% load('karate.mat')
% M = full(Problem.A);
% findCommunityPara(M,1.6);

A = csvread('Networks/Network.1/network.dat');
M = sparse(A(length(A), 1), A(length(A), 1));
M = full(M);

for i = drange(1, length(A))
        j = A(i, 1);
        k = A(i, 2);
        M(k, j) = 1;
        M(j, k) = 1;
end;
findCommunityPara(M,0.38);

