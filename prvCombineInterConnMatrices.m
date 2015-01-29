% combines all the interconnection matrices into single structure.
% interconn
%   ├── disleksi_dbmcmc_s1_prestim   : {1xN cell}
%   ├── disleksi_dbmcmc_s1_poststim  : {1xN cell}
%   ├── disleksi_dbmcmc_s2_prestim   : {1xN cell}
%   ├── disleksi_dbmcmc_s2_poststim  : {1xN cell}
%   ├── kontrol_dbmcmc_s1_prestim    : {1xN cell}
%   ├── kontrol_dbmcmc_s1_poststim   : {1xN cell}
%   ├── kontrol_dbmcmc_s2_prestim    : {1xN cell}
%   ├── kontrol_dbmcmc_s2_poststim   : {1xN cell}
%   ├── disleksi_reveal_s1_prestim   : {1xN cell}
%   ├── disleksi_reveal_s1_poststim  : {1xN cell}
%   ├── disleksi_reveal_s2_prestim   : {1xN cell}
%   ├── disleksi_reveal_s2_poststim  : {1xN cell}
%   ├── kontrol_reveal_s1_prestim    : {1xN cell}
%   ├── kontrol_reveal_s1_poststim   : {1xN cell}
%   ├── kontrol_reveal_s2_prestim    : {1xN cell}
%   └── kontrol_reveal_s2_poststim   : {1xN cell}
%

field_names = {...
    'disleksi_dbmcmc_s1_prestim', ...
    'disleksi_dbmcmc_s1_poststim', ...
    'disleksi_dbmcmc_s2_prestim', ...
    'disleksi_dbmcmc_s2_poststim', ...
    'kontrol_dbmcmc_s1_prestim',  ...
    'kontrol_dbmcmc_s1_poststim', ...
    'kontrol_dbmcmc_s2_prestim',  ...
    'kontrol_dbmcmc_s2_poststim', ...
    'disleksi_reveal_s1_prestim', ...
    'disleksi_reveal_s1_poststim', ...
    'disleksi_reveal_s2_prestim', ...
    'disleksi_reveal_s2_poststim', ...
    'kontrol_reveal_s1_prestim',  ...
    'kontrol_reveal_s1_poststim', ...
    'kontrol_reveal_s2_prestim',  ...
    'kontrol_reveal_s2_poststim'
};

interconn = [];
for i = 1:length(mat_files)
    
    if ~exist(mat_files{i}, 'file')
        continue;
    end
    
    S = load(mat_files{i}, 'Results');
    Results = S.Results;
    
    for j=1:length(Results)
        interconn.(field_names{i}){j} = Results{j}.INTERposterior;
    end
    
end

