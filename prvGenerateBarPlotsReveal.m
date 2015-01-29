%%
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

resutdir = './results_reveal';
mkdir(resutdir);

nSubject = length(interconn.disleksi_reveal_s2_prestim);
nNode = length(node_names_merged);

interstruct_merged = MergeNodes(merge_nodes, interconn.disleksi_reveal_s2_prestim);
inter_disleksi_pre = reshape(cell2mat(interstruct_merged), [nNode nNode nSubject]);

interstruct_merged = MergeNodes(merge_nodes, interconn.disleksi_reveal_s2_poststim);
inter_disleksi_post = reshape(cell2mat(interstruct_merged), [nNode nNode nSubject]);

interstruct_merged = MergeNodes(merge_nodes, interconn.kontrol_reveal_s2_prestim);
inter_kontrol_pre = reshape(cell2mat(interstruct_merged), [nNode nNode nSubject]);

interstruct_merged = MergeNodes(merge_nodes, interconn.kontrol_reveal_s2_poststim);
inter_kontrol_post = reshape(cell2mat(interstruct_merged), [nNode nNode nSubject]);

% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
nconn=0;
bar_data = [];
conn_name = [];
for i=1:length(left_nodes)
    for j=1:length(left_nodes)
       if(i == j)
           continue;
       end
       nconn = nconn + 1;
       conn_name{nconn} = sprintf('%s->%s', node_names_merged{left_nodes(i)}, ...
           node_names_merged{left_nodes(j)});
       bar_data(nconn,1) = mean(inter_disleksi_pre(left_nodes(i),left_nodes(j),:));       
       bar_data(nconn,2) = mean(inter_disleksi_post(left_nodes(i),left_nodes(j),:));
       bar_data(nconn,3) = mean(inter_kontrol_pre(left_nodes(i),left_nodes(j),:));       
       bar_data(nconn,4) = mean(inter_kontrol_post(left_nodes(i),left_nodes(j),:));
    end
end

% -------------------------------------------------------------------------
% Bar Plot 1.1 (Disleksi Group: Left Electrodes Pre-Stimulus vs. Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,1:2),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','pre-stimulus');
set(bar1(2),'DisplayName','post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi Group: Left Electrodes Pre-Stimulus vs. Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/left_disleksi_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/left_disleksi_pre_vs_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 1.2 (Kontrol Group: Left Electrodes Pre-Stimulus vs. Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,3:4),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','pre-stimulus');
set(bar1(2),'DisplayName','post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Kontrol Group: Left Electrodes Pre-Stimulus vs. Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/left_kontrol_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/left_kontrol_pre_vs_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 1.3 (Disleksi vs. Kontrol: Left Electrodes Pre-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,[1 3]),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','disleksi | pre-stimulus');
set(bar1(2),'DisplayName','kontrol | pre-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi vs. Kontrol: Left Electrodes Pre-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/left_disleksi_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/left_disleksi_vs_kontrol_pre.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 1.4 (Disleksi vs. Kontrol: Left Electrodes Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,[2 4]),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','disleksi | post-stimulus');
set(bar1(2),'DisplayName','kontrol | post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi vs. Kontrol: Left Electrodes Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/left_disleksi_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/left_disleksi_vs_kontrol_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 


% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
nconn=0;
bar_data = [];
conn_name = [];
for i=1:length(right_nodes)
    for j=1:length(right_nodes)
       if(i == j)
           continue;
       end
       nconn = nconn + 1;
       conn_name{nconn} = sprintf('%s->%s', node_names_merged{right_nodes(i)}, ...
           node_names_merged{right_nodes(j)});
       bar_data(nconn,1) = mean(inter_disleksi_pre(right_nodes(i),right_nodes(j),:));       
       bar_data(nconn,2) = mean(inter_disleksi_post(right_nodes(i),right_nodes(j),:));
       bar_data(nconn,3) = mean(inter_kontrol_pre(right_nodes(i),right_nodes(j),:));       
       bar_data(nconn,4) = mean(inter_kontrol_post(right_nodes(i),right_nodes(j),:));
    end
end

% -------------------------------------------------------------------------
% Bar Plot 2.1 (Disleksi Group: Right Electrodes Pre-Stimulus vs. Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,1:2),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','pre-stimulus');
set(bar1(2),'DisplayName','post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi Group: Right Electrodes Pre-Stimulus vs. Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/right_disleksi_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/right_disleksi_pre_vs_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 2.2 (Kontrol Group: Right Electrodes Pre-Stimulus vs. Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,3:4),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','pre-stimulus');
set(bar1(2),'DisplayName','post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Kontrol Group: Right Electrodes Pre-Stimulus vs. Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/right_kontrol_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/right_kontrol_pre_vs_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 2.3 (Disleksi vs. Kontrol: Right Electrodes Pre-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,[1 3]),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','disleksi | pre-stimulus');
set(bar1(2),'DisplayName','kontrol | pre-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi vs. Kontrol: Right Electrodes Pre-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/right_disleksi_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/right_disleksi_vs_kontrol_pre.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 2.4 (Disleksi vs. Kontrol: Right Electrodes Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,[2 4]),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','disleksi | post-stimulus');
set(bar1(2),'DisplayName','kontrol | post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi vs. Kontrol: Right Electrodes Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/right_kontrol_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/right_disleksi_vs_kontrol_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
nconn=0;
bar_data = [];
conn_name = [];
for i=1:length(left_nodes)
    for j=1:length(right_nodes)
       nconn = nconn + 1;
       conn_name{nconn} = sprintf('%s->%s', node_names_merged{left_nodes(i)}, ...
           node_names_merged{right_nodes(j)});
       bar_data(nconn,1) = mean(inter_disleksi_pre(left_nodes(i),right_nodes(j),:));       
       bar_data(nconn,2) = mean(inter_disleksi_post(left_nodes(i),right_nodes(j),:));
       bar_data(nconn,3) = mean(inter_kontrol_pre(left_nodes(i),right_nodes(j),:));       
       bar_data(nconn,4) = mean(inter_kontrol_post(left_nodes(i),right_nodes(j),:));
    end
end

% -------------------------------------------------------------------------
% Bar Plot 3.1 (Disleksi Group: Left to Right Electrodes Pre-Stimulus vs. Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,1:2),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','pre-stimulus');
set(bar1(2),'DisplayName','post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi Group: Left to Right Electrodes Pre-Stimulus vs. Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/left2right_disleksi_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/left2right_disleksi_pre_vs_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 3.2 (Disleksi Group: Left to Right Electrodes Pre-Stimulus vs. Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,3:4),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','pre-stimulus');
set(bar1(2),'DisplayName','post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi Group: Left to Right Electrodes Pre-Stimulus vs. Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/left2right_kontrol_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/left2right_kontrol_pre_vs_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 3.3 (Disleksi vs. Kontrol: Left to Right Electrodes Pre-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,[1 3]),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','disleksi | pre-stimulus');
set(bar1(2),'DisplayName','kontrol | pre-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi vs. Kontrol: Left to Right Electrodes Pre-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/left2right_disleksi_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/left2right_disleksi_vs_kontrol_pre.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 3.4 (Disleksi vs. Kontrol: Left to Right Electrodes Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,[2 4]),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','disleksi | post-stimulus');
set(bar1(2),'DisplayName','kontrol | post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi vs. Kontrol: Left to Right Electrodes Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/left2right_kontrol_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/left2right_disleksi_vs_kontrol_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
nconn=0;
bar_data = [];
conn_name = [];
for i=1:length(right_nodes)
    for j=1:length(left_nodes)
       nconn = nconn + 1;
       conn_name{nconn} = sprintf('%s->%s', node_names_merged{right_nodes(i)}, ...
           node_names_merged{left_nodes(j)});
       bar_data(nconn,1) = mean(inter_disleksi_pre(right_nodes(i),left_nodes(j),:));       
       bar_data(nconn,2) = mean(inter_disleksi_post(right_nodes(i),left_nodes(j),:));
       bar_data(nconn,3) = mean(inter_kontrol_pre(right_nodes(i),left_nodes(j),:));       
       bar_data(nconn,4) = mean(inter_kontrol_post(right_nodes(i),left_nodes(j),:));
    end
end

% -------------------------------------------------------------------------
% Bar Plot 4.1 (Kontrol Group: Right to Left Electrodes Pre-Stimulus vs. Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,1:2),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','pre-stimulus');
set(bar1(2),'DisplayName','post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Kontrol Group: Right to Left Electrodes Pre-Stimulus vs. Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/right2left_disleksi_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/right2left_disleksi_pre_vs_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 4.2 (Kontrol Group: Right to Left Electrodes Pre-Stimulus vs. Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,3:4),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','pre-stimulus');
set(bar1(2),'DisplayName','post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Kontrol Group: Right to Left Electrodes Pre-Stimulus vs. Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/right2left_kontrol_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/right2left_kontrol_pre_vs_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 4.3 (Disleksi vs. Kontrol Group: Right to Left Electrodes Pre-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,[1 3]),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','disleksi | pre-stimulus');
set(bar1(2),'DisplayName','kontrol | pre-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi vs. Kontrol Group: Right to Left Electrodes Pre-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/right2left_disleksi_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/right2left_disleksi_vs_kontrol_pre.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

% -------------------------------------------------------------------------
% Bar Plot 4.4 (Disleksi vs. Kontrol Group: Right to Left Electrodes Post-Stimulus)
% -------------------------------------------------------------------------

fig1 = figure('color', 'white', 'units', 'normalized', 'outerposition', [0 0 1 3/4]);
axes1 = axes('Parent',fig1,'YGrid','on',...
    'XTickLabel',conn_name, 'XTick',1:1:nconn, 'XGrid','on');

ylim(axes1, [0 2]); xlim(axes1,[0 (nconn+1)]); box(axes1,'on'); hold(axes1,'all');

bar1 = bar(bar_data(:,[2 4]),'BarWidth',0.4,'BarLayout','stacked','Parent',axes1);
set(bar1(1),'DisplayName','disleksi | post-stimulus');
set(bar1(2),'DisplayName','kontrol | post-stimulus');

xlabel({'','Connections','---'});
ylabel({'---','Average Connection Weight',''});
title({'---','Disleksi vs. Kontrol Group: Right to Left Electrodes Post-Stimulus',''});
legend(axes1,'show');

%saveas(fig1, sprintf('%s/right2left_kontrol_pre_vs_post.png', resutdir));
export_fig( fig1, sprintf('%s/right2left_disleksi_vs_kontrol_post.jpg', resutdir), '-painters', '-jpg', '-r144' ); 

%
clear bar_data fig1 bar1 nconn conn_name i j interstruct_* inter_*
