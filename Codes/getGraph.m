function getGraph( A,Dir,FileName )
% getDotFile The input is a graph in adjacency matrix

dotFileDir = strcat(Dir,'/',FileName,'.dot');
n = length(A);
nodes = arrayfun(@int2str,(1:n),'UniformOutput', false);
B = round(1/std(A(:))*A);
% generate dot file for neato
fid = fopen(dotFileDir, 'w');
fprintf(fid, 'graph G {\n');
for i = 1:n
    for j = i:n
        if B(i,j) >= 0.000001
            fprintf(fid, '    %s -- %s [len= %i]\n',nodes{i}, nodes{j},B(i,j));
        end
    end
end
fprintf(fid, '}\n');
fclose(fid);

% render dot file
%unix('/usr/local/bin/neato -Tpng test.dot -o test.png')
end