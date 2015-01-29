%% Installations
cd ./bnt/
addpath(genpathKPM(pwd));
cd ..

addpath(pwd);
addpath(strcat(pwd, '/DBmcmc/'));
addpath(strcat(pwd, '/export_fig'))


%% Generate Dynamic Bayesian Network

% o specify this directed acyclic graph (dag), we create an adjacency matrix:

node_names = {'O1', 'O2', 'P3', 'P4', 'P7', 'P8', 'T7', 'T8', 'C3', ...
    'C4', 'F3', 'F4', 'F7', 'F8'};

N = size(node_names,2);

% Simple Model: There are no intra-slice connections 
intra = zeros(N); 
inter = zeros(N);

% We can specify the parameters as follows, where for simplicity we assume 
% the observed node is discrete.

Q = 2; % num hidden states (-1, 1)
O = 2; % num observable symbols (-1, 1)

ns = [Q O];
dnodes = 1:N;
bnet = mk_dbn(intra, inter, ns, 'discrete', dnodes, 'names', node_names);

clear ns Q O intra inter dnodes

%% Read training data

% Use different quantization levels for post- and pre-stimulus data
prvReadTrainingData;

% Use same quantization levels for post- and pre-stimulus data
% prvReadTrainingData2
 

%% Structure Learning (Reveal) (Scenario 1)

label = 'inter_disleksi_prestim_reveal';
nodes = 1:nSubject;
for i=1:nSubject
    seqs = squeeze(num2cell(num2cell(2 + disleksi_tdata_prestim(:,:,nodes(nodes~=i))),[1 2]));
    Results{i}.INTERposterior = learn_struct_dbn_reveal(seqs, ...  
        nQuantLevels*ones(1,N));    % node_sizes
end
save(sprintf('%s.mat', label), 'Results');

label = 'inter_disleksi_poststim_reveal';
nodes = 1:nSubject;
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(2 + disleksi_tdata_poststim(:,:,nodes(nodes~=i))),[1 2]));
    Results{i}.INTERposterior = learn_struct_dbn_reveal(seqs, ...  
        nQuantLevels*ones(1,N));    % node_sizes
end
save(sprintf('%s.mat', label), 'Results');

label = 'inter_kontrol_prestim_reveal';
nodes = 1:nSubject;
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(2 + kontrol_tdata_prestim(:,:,nodes(nodes~=i))),[1 2]));
    Results{i}.INTERposterior = learn_struct_dbn_reveal(seqs, ...  
        nQuantLevels*ones(1,N));    % node_sizes
end
save(sprintf('%s.mat', label), 'Results');

label = 'inter_kontrol_poststim_reveal';
nodes = 1:nSubject;
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(2 + kontrol_tdata_poststim(:,:,nodes(nodes~=i))),[1 2]));
    Results{i}.INTERposterior = learn_struct_dbn_reveal(seqs, ...  
        nQuantLevels*ones(1,N));    % node_sizes
end
save(sprintf('%s.mat', label), 'Results');


%% Structure Learning (Reveal) (Scenario 2)

label = 'inter_disleksi_poststim_self_reveal';
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(2 + disleksi_tdata_poststim(:,:,i)),[1 2]));
    Results{i}.INTERposterior = learn_struct_dbn_reveal(seqs, ...  
        nQuantLevels*ones(1,N));    % node_sizes
end
save(sprintf('%s.mat', label), 'Results');

label = 'inter_disleksi_prestim_self_reveal';
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(2 + disleksi_tdata_prestim(:,:,i)),[1 2]));
    Results{i}.INTERposterior = learn_struct_dbn_reveal(seqs, ...  
        nQuantLevels*ones(1,N));    % node_sizes
end
save(sprintf('%s.mat', label), 'Results');

label = 'inter_kontrol_poststim_self_reveal';
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(2 + kontrol_tdata_poststim(:,:,i)),[1 2]));
    Results{i}.INTERposterior = learn_struct_dbn_reveal(seqs, ...  
        nQuantLevels*ones(1,N));    % node_sizes
end
save(sprintf('%s.mat', label), 'Results');

label = 'inter_kontrol_prestim_self_reveal';
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(2 + kontrol_tdata_prestim(:,:,i)),[1 2]));
    Results{i}.INTERposterior = learn_struct_dbn_reveal(seqs, ...  
        nQuantLevels*ones(1,N));    % node_sizes
end
save(sprintf('%s.mat', label), 'Results');

%% Structure Learning (DBMCMC) (Scenario 1)

% MCMC learning parameters
mcmcPAR.seed=11;	
mcmcPAR.nBurnIn	= 10000;	
mcmcPAR.nSample	= 10000;	
mcmcPAR.nDelta = 1;
mcmcPAR.maxFanIn = 0;	
mcmcPAR.EmaxNodeFanOut = 0;	

flag_binary = 0;
Results = cell(1, nSubject);

% Structure Learning (DBMCMC): Disleksi Pre-Stimulus
label = 'inter_disleksi_prestim_dbmcmc';
nodes = 1:nSubject;
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(disleksi_tdata_prestim(:,:,nodes(nodes~=i))),[1 2]));
    
    [data,nodeSizes]=DBmcmc_DataReadIn(...
        'data',cell2mat(seqs{1}),...
        'data',cell2mat(seqs{2}),...
        'data',cell2mat(seqs{3}),...
        'data',cell2mat(seqs{4}),...
        'data',cell2mat(seqs{5}),...
        'data',cell2mat(seqs{6}),...
        'data',cell2mat(seqs{7}),...
        'data',cell2mat(seqs{8}),...
        'data',cell2mat(seqs{9}),...
        'flag_binary',flag_binary);
    
    [INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]= DBmcmc_RunMCMC(data,...
                            nodeSizes,mcmcPAR);
                  
    %  Store results
    Results{i}.INTERposterior=INTERposterior;
    Results{i}.t_sampled=t_sampled;
    Results{i}.num_edges=num_edges;
    Results{i}.accept_ratio=accept_ratio;
 
end
save(sprintf('%s.mat', label), 'Results');

% Structure Learning (DBMCMC): Disleksi Post Stimulus
label = 'inter_disleksi_poststim_dbmcmc';
nodes = 1:nSubject;
for i=1:nSubject        
    seqs = squeeze(num2cell(num2cell(disleksi_tdata_poststim(:,:,nodes(nodes~=i))),[1 2]));
    
    [data,nodeSizes]=DBmcmc_DataReadIn(...
        'data',cell2mat(seqs{1}),...
        'data',cell2mat(seqs{2}),...
        'data',cell2mat(seqs{3}),...
        'data',cell2mat(seqs{4}),...
        'data',cell2mat(seqs{5}),...
        'data',cell2mat(seqs{6}),...
        'data',cell2mat(seqs{7}),...
        'data',cell2mat(seqs{8}),...
        'data',cell2mat(seqs{9}),...
        'flag_binary',flag_binary);
    
    [INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]= DBmcmc_RunMCMC(data,...
                            nodeSizes,mcmcPAR);
                  
    %  Store results
    Results{i}.INTERposterior=INTERposterior;
    Results{i}.t_sampled=t_sampled;
    Results{i}.num_edges=num_edges;
    Results{i}.accept_ratio=accept_ratio;
  
end
save(sprintf('%s.mat', label), 'Results');

% Structure Learning (DBMCMC): Kontrol Pre-Stimulus
label = 'inter_kontrol_prestim_dbmcmc';
nodes = 1:nSubject;
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(kontrol_tdata_prestim(:,:,nodes(nodes~=i))),[1 2]));
    
    [data,nodeSizes]=DBmcmc_DataReadIn(...
        'data',cell2mat(seqs{1}),...
        'data',cell2mat(seqs{2}),...
        'data',cell2mat(seqs{3}),...
        'data',cell2mat(seqs{4}),...
        'data',cell2mat(seqs{5}),...
        'data',cell2mat(seqs{6}),...
        'data',cell2mat(seqs{7}),...
        'data',cell2mat(seqs{8}),...
        'data',cell2mat(seqs{9}),...
        'flag_binary',flag_binary);
    
    [INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]= DBmcmc_RunMCMC(data,...
                            nodeSizes,mcmcPAR);
                  
    %  Store results
    Results{i}.INTERposterior=INTERposterior;
    Results{i}.t_sampled=t_sampled;
    Results{i}.num_edges=num_edges;
    Results{i}.accept_ratio=accept_ratio;
end
save(sprintf('%s.mat', label), 'Results');

% Structure Learning (DBMCMC): Kontrol Post Stimulus
label = 'inter_kontrol_poststim_dbmcmc';
nodes = 1:nSubject;
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(kontrol_tdata_poststim(:,:,nodes(nodes~=i))),[1 2]));
    
    [data,nodeSizes]=DBmcmc_DataReadIn(...
        'data',cell2mat(seqs{1}),...
        'data',cell2mat(seqs{2}),...
        'data',cell2mat(seqs{3}),...
        'data',cell2mat(seqs{4}),...
        'data',cell2mat(seqs{5}),...
        'data',cell2mat(seqs{6}),...
        'data',cell2mat(seqs{7}),...
        'data',cell2mat(seqs{8}),...
        'data',cell2mat(seqs{9}),...
        'flag_binary',flag_binary);
    
    [INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]= DBmcmc_RunMCMC(data,...
                            nodeSizes,mcmcPAR);
                  
    %  Store results
    Results{i}.INTERposterior=INTERposterior;
    Results{i}.t_sampled=t_sampled;
    Results{i}.num_edges=num_edges;
    Results{i}.accept_ratio=accept_ratio;
    
end
save(sprintf('%s.mat', label), 'Results');


%% Structure Learning (DBMCMC) (Scenario 2)

% MCMC learning parameters
mcmcPAR.seed=11;	
mcmcPAR.nBurnIn	= 10000;	
mcmcPAR.nSample	= 10000;	
mcmcPAR.nDelta = 1;
mcmcPAR.maxFanIn = 0;	
mcmcPAR.EmaxNodeFanOut = 0;

flag_binary = 0;
Results = cell(1, nSubject);

% Structure Learning (DBMCMC): Disleksi Pre-Stimulus
label = 'inter_disleksi_prestim_self_dbmcmc';
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(disleksi_tdata_prestim(:,:,i)),[1 2]));
    
    [data,nodeSizes]=DBmcmc_DataReadIn(...
        'data',cell2mat(seqs{1}),...
        'flag_binary',flag_binary);
    
    [INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]= DBmcmc_RunMCMC(data,...
                            nodeSizes,mcmcPAR);
                  
    %  Store results
    Results{i}.INTERposterior=INTERposterior;
    Results{i}.t_sampled=t_sampled;
    Results{i}.num_edges=num_edges;
    Results{i}.accept_ratio=accept_ratio;
    
end
save(sprintf('%s.mat', label), 'Results');

% Structure Learning (DBMCMC): Disleksi Post Stimulus
label = 'inter_disleksi_poststim_self_dbmcmc';
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(disleksi_tdata_poststim(:,:,i)),[1 2]));
    
    [data,nodeSizes]=DBmcmc_DataReadIn(...
        'data',cell2mat(seqs{1}),...
        'flag_binary',flag_binary);
    
    [INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]= DBmcmc_RunMCMC(data,...
                            nodeSizes,mcmcPAR);
                  
    %  Store results
    Results{i}.INTERposterior=INTERposterior;
    Results{i}.t_sampled=t_sampled;
    Results{i}.num_edges=num_edges;
    Results{i}.accept_ratio=accept_ratio;
     
end
save(sprintf('%s.mat', label), 'Results');

% Structure Learning (DBMCMC): Kontrol Post Stimulus
label = 'inter_kontrol_poststim_self_dbmcmc';
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(kontrol_tdata_poststim(:,:,i)),[1 2]));
    
    [data,nodeSizes]=DBmcmc_DataReadIn(...
        'data',cell2mat(seqs{1}),...
        'flag_binary',flag_binary);
    
    [INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]= DBmcmc_RunMCMC(data,...
                            nodeSizes,mcmcPAR);
                  
    %  Store results
    Results{i}.INTERposterior=INTERposterior;
    Results{i}.t_sampled=t_sampled;
    Results{i}.num_edges=num_edges;
    Results{i}.accept_ratio=accept_ratio;
    
end
save(sprintf('%s.mat', label), 'Results');


% Structure Learning (DBMCMC): Kontrol Pre-Stimulus
label = 'inter_kontrol_prestim_self_dbmcmc';
for i=1:nSubject     
    seqs = squeeze(num2cell(num2cell(kontrol_tdata_prestim(:,:,i)),[1 2]));
    
    [data,nodeSizes]=DBmcmc_DataReadIn(...
        'data',cell2mat(seqs{1}),...
        'flag_binary',flag_binary);
    
    [INTERposterior, sampled_graphs, accept_ratio, num_edges, t_sampled]= DBmcmc_RunMCMC(data,...
                            nodeSizes,mcmcPAR);
                  
    %  Store results
    Results{i}.INTERposterior=INTERposterior;
    Results{i}.t_sampled=t_sampled;
    Results{i}.num_edges=num_edges;
    Results{i}.accept_ratio=accept_ratio;
    
end
save(sprintf('%s.mat', label), 'Results');


%%




