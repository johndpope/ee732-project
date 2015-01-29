function Inter2File(node_names, inter, file_name)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if(~isempty(file_name))
    fid = fopen(file_name, 'w+');
else
    fid = 1;
end

nnode = length(node_names);

% Write node names
fprintf(fid, '     |');
for i=1:nnode
    fprintf(fid, '%8s', node_names{i});
end
fprintf(fid, '\n');

for i=1:(nnode*8 + 6)
    fprintf(fid, '-');
end
fprintf(fid, '\n');

for i=1:nnode
    fprintf(fid, '%4s |', node_names{i});
    for j=1:nnode
        if(inter(i,j) ~= 0)
            fprintf(fid, '%8.4f', inter(i,j));
        else
            fprintf(fid, '%8d', 0);
        end
    end
    fprintf(fid, '\n');
end

for i=1:(nnode*8 + 6)
    fprintf(fid, '-');
end
fprintf(fid, '\n');

if (fid > 2)
    fclose(fid);

end

