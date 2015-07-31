% load('karate.mat')
% M = full(Problem.A);
% findCommunityPara(M,0.5420);

A = csvread('directed_networks/network.dat');
M = sparse(A(length(A), 1), A(length(A), 1));
M = full(M);

for i = drange(1, length(A))
        j = A(i, 1);
        k = A(i, 2);
        M(k, j) = 1;
        M(j, k) = 1;
end;

findCommunityPara(M,0.412);