function options = sdpoptionset(varargin)

% SDPOPTIONSET is used to set options for fminsdp. 
%
% Example:
%
% >> options = sdpoptionset('NLPsolver','fmincon','Algorithm','interior-point');
% >> fminsdp(...,options);
%
% To see the available options, simply run
%
% >> sdpoptionset
%
%
% See also FMINSDP, OPTIMSET

fminsdpoptions = {'NLPsolver',...
    'Ldiag_low',...
    'L_low',...
    'L_upp',...
    'sp_pattern',...
    'Aind',...
    'ipopt',...
    'HessianCheck',...
    'HessianCheckLL',...
    'c',...
    's_low',...
    's_upp',...
    'L0',...
    'KnitroOptionsFile',...
    'SnoptOptionsFile',...
    'eigs_opts',...
    'HessMult',...
    'MatrixInequalities',...
    'GradPattern',...
    'lambda',...
    'zl',...
    'zu',...
    'lb_linear',...
    'lb_cineq',...
    'ub_cineq',...
    'a0',...
    'a',...
    'c_mma',...
    'd',...,
    'asyinit',...
    'asyincr',...
    'asydecr',...
    'raa0',...
    'raa0eps',...
    'raa',...
    'raaeps',...
    'epsimin'};

if (nargin == 0) && (nargout == 0)
    fprintf('\nOptions available for fminsdp (default values in brackets):\n\n');   
    fprintf('Aind:               [{1}, numeric array]\n');
    fprintf('NLPsolver:          [{''fmincon''}, ''ipopt'', ''knitro'', ''snopt'', ''mma'', ''gcmma'']\n');
    fprintf('Ldiag_low:          [{0}, scalar or array of doubles]\n');
    fprintf('L_low:              [{-inf}, scalar or array of doubles]\n');
    fprintf('L_upp:              [{inf}, scalar or array of doubles]\n');
    fprintf('L0:                 [{[]}, (sparse) matrix or cell array of matrices]\n');
    fprintf('sp_pattern:         [{[]}, (sparse) matrix or cell array of matrices]\n');    
    fprintf('HessianCheck:       [{''off''}, char]\n');
    fprintf('c:                  [{0}, double]\n');
    fprintf('s_low:              [{0}, double]\n');
    fprintf('s_upp:              [{inf}, double]\n');        
    fprintf('eigs_opts:          [{[]}, struct]\n');    
    fprintf('MatrixInequalities: [{true}, false]\n');      
    fprintf('lambda:             [{[]}, struct or array of doubles]\n'); 
    fprintf('\nAdditional options for fmincon and Knitro:\n');
    fprintf('HessMult:           [{[]}, ''on'', function_handle]\n');
    fprintf('\nAdditional options for Knitro:\n');
    fprintf('KnitroOptionsFile:  [{[]}, char]\n');
    fprintf('\nAdditional options for Snopt:\n');
    fprintf('SnoptOptionsFile:   [{[]}, char]\n');
    fprintf('GradPattern:        [{[]}, (sparse) matrix]\n'); 
    fprintf('\nAdditional options for Ipopt:\n');
    fprintf('ipopt:              [{[]}, struct]\n');
    fprintf('zl:                 [{[]}, array of doubles]\n'); 
    fprintf('zu:                 [{[]}, array of doubles]\n'); 
    fprintf('lb_linear:          [{[]}, scalar or array of doubles]\n'); 
    fprintf('lb_cineq:           [{[]}, scalar or array of doubles]\n'); 
    fprintf('ub_cineq:           [{[]}, scalar or array of doubles]\n'); 
    fprintf('\nAdditional options for mma and gcmma:\n');
    fprintf('a0:                 [{1}, positive double]\n');
    fprintf('a:                  [{0}, scalar or array of non-negative doubles]\n'); 
    fprintf('c_mma:              [{100}, scalar or array of non-negative doubles]\n'); 
    fprintf('d:                  [{1}, scalar or array of doubles]\n'); 
    fprintf('asyinit:            [{0.4},positive double]\n');
    fprintf('asyincr:            [{1.2},positive double]\n');
    fprintf('asydecr:            [{0.5},positive double]\n');
    fprintf('\nAdditional options for gcmma:\n');
    fprintf('MaxInnerIter:       [{50},double]\n');
    fprintf('raa0:               [{1e-2}, positive scalar]\n');
    fprintf('raa0eps:            [{1e-5}, positive scalar]\n');
    fprintf('raa:                [{1e-2}, scalar or array of positive doubles]\n');
    fprintf('raaeps:             [{1e-5}, scalar or array of positive doubles]\n');
    fprintf('epsimin:            [{1e-7}, positive scalar\n');
    fprintf('\nType ''help fminsdp'' for additional details.\n');
    fprintf('\n(Type ''optimset'' to see options available to fmincon.)\n');
    return;
end

n_fields = numel(varargin);
if mod(n_fields,2)
    error('Input arguments must appear as parameter-value pairs');
end

optimnames = fieldnames(optimset);

options = [];
for i = 1:2:n_fields
    if ~isa(varargin{i},'char')
        error('Input arguments must appear as parameter-value pairs');
    elseif any(strcmpi(varargin{i},fminsdpoptions));
        % Options only available with fminsdp. The validity of the values
        % are checked later when calling fminsdp.       
       name = char(fminsdpoptions(strcmpi(fminsdpoptions,varargin{i})));
       options.(name) = varargin{i+1};
    else 
        % Let optimset take care of the other options
        optimset(varargin{i},varargin{i+1});
        name = char(optimnames(strcmpi(optimnames,varargin{i})));
        options.(name) = varargin{i+1};
    end
end