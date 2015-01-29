%% Read and quantize training data

% Quantization:
%   (-Inf   , mu-std) -> -1 
%   [mu-std , mu+std] ->  0 
%   (mu+std , Inf   ) ->  1  

% disleksi training set
tmp = dir('./data/disleksi/*.mat');
disleksi_tdata_filename = strcat('./data/disleksi/', {tmp.name});

t_len = 400;
t_start_pre = 501;
t_end_pre = t_start_pre + t_len;
t_start_post = 1101;
t_end_post = t_start_post + t_len;

nSubject = size(disleksi_tdata_filename,2); 
disleksi_tdata_prestim = zeros(N, t_len, nSubject);
disleksi_tdata_poststim = zeros(N, t_len, nSubject);

for i=1:nSubject
    data = load('-mat', disleksi_tdata_filename{i});
    for j = 1:size(node_names, 2) 
        % Quantization ((-Inf,mu-std)->-1, [mu-std,mu+std] -> 0, (mu+std, Inf) -> 1)
        mu = mean(double(data.(node_names{j}))); 
        stdev = std(double(data.(node_names{j})));
        
        samples = double(data.(node_names{j})(t_start_pre:t_end_pre))';
        qdata =  1 * (samples > (mu + stdev)) + ...
                 0 * (samples <= (mu + stdev) & samples >= (mu - stdev)) + ...
                -1 * (samples < (mu - stdev));  
        disleksi_tdata_prestim(j,:,i) = qdata;
        
        samples = double(data.(node_names{j})(t_start_post:t_end_post))';
        qdata =  1 * (samples > (mu + stdev)) + ...
                 0 * (samples <= (mu + stdev) & samples >= (mu - stdev)) + ...
                -1 * (samples < (mu - stdev));  
        disleksi_tdata_poststim(j,:,i) = qdata;
    end
end


% control training set
tmp = dir('./data/kontrol/*.mat');
kontrol_tdata_filename = strcat('./data/kontrol/', {tmp.name});

nSubject = size(kontrol_tdata_filename,2); 
kontrol_tdata_prestim = zeros(N, t_len, nSubject);
kontrol_tdata_poststim = zeros(N, t_len, nSubject);

for i=1:nSubject
    data = load('-mat', kontrol_tdata_filename{i});
    for j = 1:size(node_names, 2)    
        % Quantization ((-Inf,mu-std)->-1, [mu-std,mu+std] -> 0, (mu+std, Inf) -> 1)
        mu = mean(double(data.(node_names{j}))); 
        stdev = std(double(data.(node_names{j})));
        
        samples = double(data.(node_names{j})(t_start_pre:t_end_pre))';
        qdata =  1 * (samples > (mu + stdev)) + ...
                 0 * (samples <= (mu + stdev) & samples >= (mu - stdev)) + ...
                -1 * (samples < (mu - stdev));  
        kontrol_tdata_prestim(j,:,i) = qdata;
        
        samples = double(data.(node_names{j})(t_start_post:t_end_post))';
        qdata =  1 * (samples > (mu + stdev)) + ...
                 0 * (samples <= (mu + stdev) & samples >= (mu - stdev)) + ...
                -1 * (samples < (mu - stdev));  
        kontrol_tdata_poststim(j,:,i) = qdata;
    end
end

clear *_tdata_filename data tmp qdata samples mu stdev i j
