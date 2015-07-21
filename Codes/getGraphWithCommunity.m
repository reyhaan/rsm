function  getGraphWithCommunity(A, L,Dir,FileName)
%GETGRAPHWITHCOMMUNITY A is the adjacency matrix of the graoh. L is the
%list of nodes of a community. 
%   Note: In our model, there might be some overlaps. 
%   i.e A node might belong to more than one community. For convenience, we
%   will not plot all communites in one graph. Instead, we plot them one by 
%   one.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Author: Haoye(Field) Lu
%   Email: hlu044@uottawa.ca

dotFileDir = strcat(Dir,'/',FileName,'.dot');
%pngFileDir = strcat(Dir,'/',FileName,'.png');
%neatoCmd = ['/usr/local/bin/neato -Tpng ',dotFileDir,' -o ',pngFileDir];
%display(dotFileDir);
n = length(A);
nodes = arrayfun(@int2str,(1:n),'UniformOutput', false);
B = round(1/std(A(:))*A);
% generate dot file for neato
fid = fopen(dotFileDir, 'w');
fprintf(fid, 'graph G {\n');

for i = 1:length(L)
    fprintf(fid,'    %i [style=filled, color="#CCFFFF"];\n',L(i));
end

for i = 1:n
    for j = i:n
        if B(i,j) ~= 0
            fprintf(fid, '    %s -- %s [len= %i]\n',nodes{i}, nodes{j},B(i,j));
        end
    end
end
fprintf(fid, '}\n');
fclose(fid);

% render dot file
%unix(neatoCmd)
end

