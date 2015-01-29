function [ inter_merged ] = MergeNodes(merge_nodes, inter)
%MergeNodes merge nodes, and generate new interconnection matrices

    inter_merged = inter;
    for j=1:length(inter)
        for k=1:size(merge_nodes)
            inter_merged{j}(merge_nodes(k,1), :) = 0.5 * (...
                inter{j}(merge_nodes(k,1), :) + ...
                inter{j}(merge_nodes(k,2), :));
            % set self-connection weight to 1
            inter_merged{j}(merge_nodes(k,1), merge_nodes(k,1)) = 1; 
        end

        inter_merged{j}(merge_nodes(:,2), :) = [];
        inter_merged{j}(:, merge_nodes(:,2)) = [];
    end
    
end

