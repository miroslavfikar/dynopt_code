function [xval,fval,exitflag,output,lambda,grad,hessian] = ...
    mma_main(fun,x0,A,B,Aeq,Beq,lb,ub,nonlcon,options,...
             data,ceq,cineq)

% Interface to NLP-solvers MMA and GCMMA. Intended for use with fminsdp,
% but it can also be used as a stand-alone interface.
%
% This function solves the following problem (see ref. [1] below):
%
%      Minimize  f_0(x) + a_0*z + sum( c_i*y_i + 0.5*d_i*(y_i)^2 )
%    subject to  f_i(x) - a_i*z - y_i <= 0,  i = 1,...,m
%                xmin_j <= x_j <= xmax_j,    j = 1,...,n
%                z >= 0,   y_i >= 0,         i = 1,...,m
%
% where the following must hold:
%
%  a_0 > 0, a_i >= 0, c_i >= 0,
%  c_i+d_i > 0 for all i,
%  a_ic_i > 0 whenever a_i > 0.
%
% To solve a standard NLP, set
%
% a0 = 1, a_i = 0, d_i = 1 and c_i = ''a large number ''
%
% The following options are available (default values in brackets):
%
% a0:          [{1},positive double]
% a:           [{0},array of non-negative doubles]
% c_mma:       [{1000}, scalar or array of non-negative doubles]\n'
% d:           [{1}, scalar or array of doubles]
% asyinit:    [{0.4},double]
% asyincr:    [{1.2},double]
% asydecr:    [{0.5},double]
%
% MaxIter:    1000,
% NLPsolver:  [{'mma'},'gcmma']
% PlotFcns:   [{[]},function handle],
% TolX:       1e-4
% TolFun:     1e-4
% TolCon:     1e-4

% Additional options for gcmma:
% MaxInnerIter: [{50},double];
% raa0:         [{1e-2}, positive scalar]
% raa0eps:      [{1e-5}, positive scalar]
% raa:          [{1e-2}, scalar or array of positive doubles]
% raaeps:       [{1e-5}, scalar or array of positive doubles]
% epsimin:      [{1e-7}, positive scalar
%
%
% NOTE: This function has been tested with MMA and GCMMA, versions September 2007
%
% References 
% [1] "MMA and GCMMA, versions September 2007", K Svanberg
%
% TODO: MMA subproblem where linear objective and constraints are not 
%       approximated - there is no need to do that!
%
%
% See also FMINSDP

if nargin<10
    error('mma_main requires at least 10 input argument');
end

defaults = struct(...
    'a0',1,...
    'a',0,...
    'c_mma',1000,...
    'd',1,...
    'asyinit',0.4,...
    'asyincr',1.2,...
    'asydecr',0.5,...
    'MaxIter',1000,...
    'MaxInnerIter',50,...
    'raa0',0.01,...
    'raa0eps',0.00001,...
    'raa',0.01,...
    'raaeps',0.000001,...
    'epsimin',0.0000001,...
    'PlotFcns',[],...
    'NLPsolver','mma',...
    'TolX',1e-4,...
    'TolFun',1e-4,...
    'TolCon',1e-4);

if nargin>9
    options = parseOptions(defaults,options);
end

if nargin<10
    options = parseOptions(defaults);
    if nargin < 9
        nonlcon = [];
    end
end

x0 = x0(:);
noVariables = length(x0);

% fmincon uses 'inf' to signify abscence of
% upper or lower bounds. This is not possible
% with mma/gcmma
if isempty(lb)
    lb = -1e12*ones(noVariables,1);
    fprintf('No lower bounds given. Setting lower bounds to -1e12 for all variables.\n\n');
end
if isempty(ub)
    ub = 1e12*ones(noVariables,1);
    fprintf('No upper bounds given. Setting upper bounds to 1e12 for all variables.\n\n');
end
lb(isinf(lb)) = sign(lb(isinf(lb)))*1e12;
ub(isinf(ub)) = sign(ub(isinf(ub)))*1e12;
lb = lb(:);
ub = ub(:);

xval = x0;
xold1 = xval;
xold2 = xval;

low = 1.1*lb-0.1*ub;
upp = 1.1*ub-0.1*lb;

% Objective function value and gradient
[f0val,df0dx] = fun(xval);

% For unconstrained problems MMA requires a dummy constraint
fval = 0;
nConstraints = 0;
dfdx = zeros(1,noVariables);
noLinearIneqConstraints = 0;
noLinearEqConstraints = 0;

% Linear inequality constraints functions and gradients
if ~isempty(A)
    if isempty(B)
        error('Empty right hand side in linear constraints equation A*x<=B');
    end
    noLinearIneqConstraints = size(A,1);
    fval(1:noLinearIneqConstraints,1) = A*x0-B;
    dfdx(1:noLinearIneqConstraints,:) = A;
end

% Linear equality constraints. Must be converted to inequality constraints
% so
% Aeq*x = Beq <=> Aeq*x <= Beq & -Aeq*x <= -Beq
if ~isempty(Aeq)
    if isempty(Beq)
        error('Empty right hand side in linear constraints equation Aeq*x=Beq');
    end
    ind1 = noLinearIneqConstraints+size(Beq,1);
    ind2 = ind1 + size(Beq,1);
    fval(ind1,1) = Aeq*x0-Beq;
    fval(ind2,1) = -Aeq*x0+Beq;
    dfdx(ind1,:) = Aeq;
    dfdx(ind2,:) = -Aeq;
    noLinearEqConstraints = 2*size(Beq,1);
    % Quick fix
    atemp = zeros(2*size(Beq,1),1);
end



% Nonlinear constraint functions and gradients
% Again we must convert equality constraints to pairs
% of inequality constraints
%
% ceq = 0 <=> ceq<=0 & -ceq<=0
%
if ~isempty(nonlcon)
    
    if strcmpi(options.GradConstr,'on')
        [cineq,ceq,gradcineq,gradceq] = feval(nonlcon,xval);
    else
        error(['You must provide analytical gradients for both ' ...
            'objective and constraint functions since finite ' ...
            'differencing is not implemented yet. ' ...
            'Set GradObj and GradConstr to ''on'' in the options.']);
    end
    
    ind3 = 0;
    if ~isempty(cineq)
        ind3 = nConstraints+(1:numel(cineq));
        fval(ind3,1) = cineq;
        if ~isempty(gradcineq)
            dfdx(ind3,:) = gradcineq';
        end
    end
    ind4 = max(ind3)+(1:numel(ceq));
    ind5 = max(ind4)+(1:numel(ceq));
    
    if ~isempty(ceq)
        fval(ind4,1) = ceq;
        fval(ind5,1) = -ceq;
        if ~isempty(gradceq)
            dfdx(ind4,:) = gradceq';
            dfdx(ind5,:) = -gradceq';
        end
    end
    
end
nConstraints = size(fval,1);

a0 = options.a0;
if numel(a0)>1 || ~isa(a0,'double') || a0 <= 0
    error('options.a0 must be a positive, real number')
end
a = options.a;
if ~isa(a,'double') || (numel(a)~=nConstraints && numel(a)~=1) || any(a<0)
    error('options.a must be an array of non-negative doubles of length = 1 or number of constraints');
elseif numel(a)~=nConstraints
    a = a*ones(nConstraints,1);
end
c = options.c_mma;
if ~isa(c,'double') || (numel(c)~=nConstraints && numel(c)~=1) || any(c<0)
    error('options.c must be an array of non-negative doubles of length = 1 or number of constraints');
elseif numel(c)~=nConstraints
    c = c*ones(nConstraints,1);
end
d = options.d;
if ~isa(d,'double') || (numel(d)~=nConstraints && numel(d)~=1) 
    error('options.d must be an array of doubles of length = 1 or number of constraints');
elseif numel(d)~=nConstraints
    d = d*ones(nConstraints,1);
end
a = a(:); 
c = c(:);
d = d(:);


% NOTE: Quick fix to handle linear equality constraints
if size(a,1) && exist('atemp','var')
    a = atemp;
end

if strcmpi(options.NLPsolver,'gcmma')
    raa0 = options.raa0;
    if numel(raa0)>1 || ~isa(raa0,'double') || raa0 <= 0
        error('options.raa0 must be a positive, real number')
    end
    raa0eps = options.raa0eps;
    if numel(raa0eps)>1 || ~isa(raa0eps,'double') || raa0eps <= 0
        error('options.raa0eps must be a positive, real number')
    end
    raa = options.raa;
    if ~isa(raa,'double') || (numel(raa)~=nConstraints && numel(raa)~=1) || any(raa<0)
        error('options.raa must be an array of non-negative doubles of length = 1 or number of constraints');
    elseif numel(raa)~=nConstraints
        raa = raa*ones(nConstraints,1);
    end
    raaeps = options.raaeps;
    if ~isa(raaeps,'double') || (numel(raaeps)~=nConstraints && numel(raaeps)~=1) || any(raaeps<0)
        error('options.raaeps must be an array of non-negative doubles of length = 1 or number of constraints');
    elseif numel(raaeps)~=nConstraints
        raaeps = raaeps*ones(nConstraints,1);
    end
    epsimin = options.epsimin;
    if numel(epsimin)>1 || ~isa(epsimin,'double') || epsimin <= 0
        error('options.raa0 must be a positive, real number')
    end
end

if isfield(options,'DerivativeCheck') && strcmpi(options.DerivativeCheck,'on')
    warning('Derivative check not implemented. Set options.NLPsolver to ''fmincon'' to check derivatives.');
end

iter = 0;
if ~isempty(options.PlotFcns)
    figure('Name','Iterations histories');
    feval(options.PlotFcns,x0,struct('fval',f0val,'iteration',iter),'iter');
end

% Number of function evaluations
fcount = 1;

if ~strcmpi(options.Display,'none')
    fprintf('\n******   Running NLP solver %s   *******\n\n',options.NLPsolver);
    fprintf(' Iter F-count      f(x)       Feasibility ');
    if strcmpi(options.NLPsolver,'gcmma')
        fprintf('   Inner iter');
    end
end

%
% Start optimization!
%
for iter=1:options.MaxIter
    
    if ~strcmpi(options.Display,'none')
        constrviol = max(max(0,fval));
        fprintf('\n%4d   %4d     %9.5e    %9.3e  ',iter,fcount,f0val,constrviol);
    end
    
    %
    % Solve subproblems
    %
    if strcmpi(options.NLPsolver,'mma')
        
        % Generate and solve MMA subproblem
        [xmma,ymma,zmma,lam,xsi,eta,mu,zet,s,low,upp] = ...
            mmasub(nConstraints,noVariables,iter,xval,lb,ub,xold1,xold2, ...
            f0val,df0dx,fval,dfdx,low,upp,a0,a,c,d,...
            options.asyinit,options.asyincr,options.asydecr);
        
    elseif strcmpi(options.NLPsolver,'gcmma')
        
        % 1. Compute lower and upper asymptotes and parameters rho
        [low,upp,raa0,raa] = asymp(iter,noVariables,xval,xold1,xold2,lb,ub,low,upp, ...
            raa0,raa,raa0eps,raaeps,df0dx,dfdx);
        
        % 2. Inner iteration of GCMMA algorithm
        for nu=1:options.MaxInnerIter
            
            % 2b. Formulate and solve GCMMA subproblem at current iteration
            %    point.
            [xmma,ymma,zmma,lam,xsi,eta,mu,zet,s,f0app,fapp] = ...
                gcmmasub(nConstraints,noVariables,iter,epsimin,xval,lb,ub,low,upp, ...
                raa0,raa,f0val,df0dx,fval,dfdx,a0,a,c,d);
            
            % 2c. Compute function values at new point xmma (Note that derivatives
            %    are not needed
            f0valnew = fun(xmma);
            fcount = fcount+1;
            
            fvalnew = 0;
            % Linear constraint function values
            if noLinearIneqConstraints>0
                fvalnew(1:noLinearIneqConstraints) = A*xmma-B;
            end
            
            if noLinearEqConstraints>0
                fvalnew(ind1) = Aeq*xmma-Beq;
                fvalnew(ind2) = -Aeq*xmma+Beq;
            end
            
            % Nonlinear constraint functions and gradients
            if ~isempty(nonlcon)
                [cineq,ceq] = feval(nonlcon,xmma);
                if ~isempty(cineq)
                    fvalnew(ind3,1) = cineq;
                end
                if ~isempty(ceq)
                    fvalnew(ind4,1) = ceq;
                    fvalnew(ind5,1) = -ceq;
                end
            end
            
            % 2d. Check conservatism of the approximations
            if concheck(nConstraints,epsimin,f0app,f0valnew,fapp,fvalnew);
                break;
            else
                % 2e. Update parameters rho
                [raa0,raa] = raaupdate(xmma,xval,lb,ub,low,upp,f0valnew,fvalnew, ...
                    f0app,fapp,raa0,raa,raa0eps,raaeps,epsimin);
            end
            
        end
        
        if nu==options.MaxInnerIter
            fprintf(['       Max inner iterations (' num2str(nu) ')']);
        else
            fprintf(['       '  num2str(nu)]);
        end
        
    else
        error('Unknown algorithm. Available choices are {mma,gcmma}.');
    end
    %
    % Finished solving subproblems
    %
    
    % Evaluate Objective function value and gradient at the solution point
    % of the MMA/GCMMA subproblem
    [f0val_new,df0dx] = fun(xmma);
    fcount = fcount+1;
    
    % Linear constraint function values
    if noLinearIneqConstraints>0
        fval(1:noLinearIneqConstraints) = A*xmma-B;
    end
    if noLinearEqConstraints>0
        fval(ind1) = Aeq*xmma-Beq;
        fval(ind2) = -Aeq*xmma+Beq;
    end
    
    % Nonlinear constraint functions and gradients
    if ~isempty(nonlcon)
        gradcineq = [];
        gradceq = [];
        if strcmpi(options.GradConstr,'off')
            [cineq,ceq] = feval(nonlcon,xmma);
        elseif strcmpi(options.GradConstr,'on')
            [cineq,ceq,gradcineq,gradceq] = feval(nonlcon,xmma);
        end
        if ~isempty(cineq)
            fval(ind3,1) = cineq;
            if ~isempty(gradcineq)
                dfdx(ind3,:) = gradcineq';
            end
        end
        if ~isempty(ceq)
            fval(ind4,1) = ceq;
            fval(ind5,1) = -ceq;
            if ~isempty(gradceq)
                dfdx(ind4,:) =  gradceq';
                dfdx(ind5,:) = -gradceq';
            end
        end
        
    end
    
    % Check termination criteria
    if abs(f0val-f0val_new)  < options.TolFun*(1+abs(f0val)) && ...          % Function value
            norm(xmma-xval,'inf') < options.TolX*(1+norm(xval,'inf')) && ... % Change in design
            max(max(fval)) < options.TolCon                                  % Constraint violation
        fprintf(['\n\nChange in objective function value less than or equal to options.TolFun (%1.3e) and ' ...
            '\nChange in design less than or equal to options.TolX (%1.3e)\n\n'],options.TolFun,options.TolX);
        f0val = f0val_new;
        xval = xmma;
        break;
    else
        f0val = f0val_new;
    end
    
    % Call plot function if available
    if ~isempty(options.PlotFcns)
        feval(options.PlotFcns,xmma,struct('fval',f0val,'iteration',iter),'iter');
        drawnow
    end
    
    % Update design variables
    xold2 = xold1;
    xold1 = xval;
    xval = xmma;
    
end
% end of main loop

if iter==options.MaxIter && ~strcmpi(options.Display,'none')
    fprintf('\n\nSolver stopped prematurely.\n\n');
    fprintf('%s stopped because it exceeded the iteration limit, \n options.MaxIter = %d.\n\n',...
             options.NLPsolver,options.MaxIter);    
end


if nargout>1
    fval = f0val;
    if nargout>2
        exitflag = 0;
        if nargout>3
            output = struct('iterations',iter,...
                'funcCount',fcount,'constrviolation',max(max(fval)),...
                'ymma',ymma,'zmma',zmma,'message',options.NLPsolver);
            if nargout>4
                lambda = [];
                if nargout >5
                    grad = [df0dx dfdx'];
                    if nargout > 6
                        hessian = [];
                    end
                end
            end
        end
    end
end
% End of mma_main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function options = parseOptions(defaults,options)
%
% PARSEOPTIONS creates or modifies an options struct.
%
% OPTIONS = PARSEOPTIONS(DEFAULTS) where DEFAULTS is a struct containing
% any default options. OPTIONS is a struct of type
%
% struct('parname1',val1,'parname2,val2....)
%
% OPTIONS = PARSEOPTIONS(DEFAULTS,OPTIONS) where OPTIONS is a struct
% containing some or all of the parameters in the DEFAULTS structs.
%
% Parameters which are not part of the OPTIONS struct will be set to their
% default value.
%
% TODO: Add checks for valid options
% TODO: Produce a warning if two fields have the same name

if nargin<1
    error('Provide default options.')
elseif nargin==1
    options = defaults;
    return;
end

fnames = fieldnames(defaults);      % Extract fieldnames
noFields = numel(fnames);

for k=1:noFields
    % Run through the options struct and see which fields are set
    % if a field is not set, set to default value
    if ~isfield(options,fnames{k}) || isempty(options.(fnames{k}))
        options.(fnames{k}) = defaults.(fnames{k});
    end
end
