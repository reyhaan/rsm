function VV= demo(M)
% function VV= GCModulMax3(A)
% Modularity Maximization community detection
%
% This is a front end for fast_newman.m, E. le Martelot's implementation 
% of Newman's greedy agglomaerative modularity maximization method
% Newman, Mark EJ. "Fast algorithm for detecting community structure in 
% networks." Physical review E 69.6 (2004): 066133. 
%
% INPUT
% A:      Adjacency matrix of graph
%
% OUTPUT
% VV:     N-ny-1 matrix, VV(n) is teh cluster to which node n belongs 
%
% EXAMPLE
% [A,V0]=GGGirvanNewman(32,4,16,0,0);
% VV=GCModulMax3(A);
%
N=length(M);
W=PermMat(N);                     % permute the graph node labels
M=W*M*W';

[VV,Q] = fast_newman(M);

VV=W'*VV;                         % unpermute the graph node labels

end