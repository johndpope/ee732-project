function SaveGraphFigure(inter, node_names, gtitle, fname)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    unfold = 2;
    flip = 1;

    N = length(node_names);
    
    theta = linspace(0,2*pi,N+1);
    X = 0.5 + (1/3) * cos(theta(1:end-1));
    Y = 0.5 + (1/3) * sin(theta(1:end-1));
    isBox = zeros(1, N);
    
    scrsz = get(0,'ScreenSize');
    figure('color', 'white', 'Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]), subplot(1,2,1); 
    draw_graph(inter>0, node_names, isBox, X, Y);
    title({'---',gtitle,' '});

    subplot(1,2,2); 
    draw_dbn(zeros(N,N), inter>0, flip, unfold, node_names);
    title({'---',gtitle,' '});
    
    %saveas(gcf, fname);
    export_fig(gcf, fname, '-painters', '-jpg', '-r144' ); 
end

