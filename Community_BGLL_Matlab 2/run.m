n1 = csvread('network_1.dat');
Matrix = sparse(25, 25);
Matrix = full(Matrix);
for i = drange(1, length(n1))
        j = n1(i, 1);
        k = n1(i, 2);
        Matrix(j, k) = 1;
        Matrix(k, j) = 1;
end;

cluster_jl_cpp(Matrix,1,1,1);