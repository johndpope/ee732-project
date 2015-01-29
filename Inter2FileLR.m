function Inter2FileLR(node_names, inter, file_name, lnodes, rnodes)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if(~isempty(file_name))
    fid = fopen(file_name, 'w+');
else
    fid = 1;
end

n_lnode = length(lnodes);
n_rnode = length(rnodes);

% Write node names
fprintf(fid, '     |');
for i=1:n_rnode
    fprintf(fid, '%8s', node_names{rnodes(i)});
end
fprintf(fid, '\n');

for i=1:(n_rnode*8 + 6)
    fprintf(fid, '-');
end
fprintf(fid, '\n');

for i=1:n_lnode
    fprintf(fid, '%4s |', node_names{lnodes(i)});
    for j=1:n_rnode
        if(inter(lnodes(i),rnodes(j)) ~= 0)
            fprintf(fid, '%8s', 'X');
        elseif (inter(rnodes(j),lnodes(i)) ~= 0)
            fprintf(fid, '%8s', 'X');
        else
            fprintf(fid, '%8s', '-');
        end
    end
    fprintf(fid, '\n');
end

if (fid > 2)
    fclose(fid);

end
