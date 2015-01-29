function SaveGraphFigureLR(inter, node_names, gtitle, fname, left_nodes, right_nodes)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

   
    n_left_nodes = length(left_nodes);
    n_right_nodes = length(right_nodes);
    n_node = n_left_nodes + n_right_nodes;
    X = zeros(1, n_node);
    Y = zeros(1, n_node);
    isBox = zeros(1, n_node);
    
    theta = linspace(120,240,length(left_nodes)) * pi / 180;
    X(left_nodes) = 0.5 + (9/20) * cos(theta(1:end));
    Y(left_nodes) = 0.5 + (9/20) * sin(theta(1:end));
    
    theta = linspace(420, 300,length(right_nodes)) * pi / 180;
    X(right_nodes) = 0.5 + (9/20) * cos(theta(1:end));
    Y(right_nodes) = 0.5 + (9/20) * sin(theta(1:end));
    
    scrsz = get(0,'ScreenSize');
    figure('color', 'white', 'Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
    [~,~,h] = draw_graph(inter>0, node_names, isBox, X, Y);
    for i=1:length(left_nodes)
        set(h(left_nodes(i),2), 'FaceColor', 'cyan');
    end
    for i=1:length(right_nodes)
        set(h(right_nodes(i),2), 'FaceColor', 'g');
    end
    
    
    for i=1:(n_node-1)
        for j=(i+1):n_node
            dir = 0;
            if(inter(i,j) > 0)
                dir = 1;
                label1 = sprintf('%.4f', inter(i,j));
            end
            if(inter(j,i) > 0)
                if(dir == 1)
                    dir = 3;
                else
                    dir = 2;
                end
                label2 = sprintf('%.4f', inter(j,i));
            end
            if(dir == 1)
                text((X(i)+X(j))/2, (Y(i)+Y(j))/2, label1);    
            elseif (dir == 2)
                text((X(i)+X(j))/2, (Y(i)+Y(j))/2, label2);
            elseif (dir == 3)
                text((X(i)+X(j))/2, (Y(i)+Y(j))/2, {label1,label2});
            end
        end
    end
    
    title({'---',gtitle,' '});

    % saveas(gcf, fname);
    export_fig(gcf, fname, '-painters', '-jpg', '-r144' ); 
    
end