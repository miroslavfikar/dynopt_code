function [optimout,optim_param] = dynopt(optim_param)
% DYNOPT - finds a constrained minimum of a function of several variables.
% DYNOPT solves problems of dynamic systems of the form:
%     min {G(x(tf),p,tf)}  
%  {u(t),p,tf}           
%  or
%    min sum_{i=1}^{nm}{S(t_{i},x(ti),u(ti),p,x^{mes}(ti))}
%  {u(t),p}                
%  subject to:
%           dx(t) = F(t,x(t),u(t),p)
%             g(u(t),x(t),p) <= 0 
%             h(u(t),x(t),p) = 0  
%          x(t)^L <= x(t) <= x(t)^U
%          u(t)^L <= u(t) <= u(t)^U    
%             p^L <=   p  <= p^U    
%
% input arguments in OPTIMPARAM structure:
%--------------------------------------------------------------------------
%  OPTVAR: says which variables have to be optimised. It can be set as
%          follows:
%          1: optimisation variables are: t
%          2: optimisation variables are: u
%          3: optimisation variables are: t, u
%          4: optimisation variables are: p
%          5: optimisation variables are: t, p
%          6: optimisation variables are: u, p
%          7: optimisation variables are: t, u, p
%  OBJTYPE: represents the type of objective function used in optimisation.
%           It can be set as follows:
%                []: Mayer type objective function is used
%           objtype: Sum type objective function is used. objtype is a
%                    structure containing variables tm, xm. tm is an
%                    nm-by-1 vector of times of taken measurements and xm
%                    is nx-by-nm matrix of afore mentioned measurements
%                    taken in times tm.
%   NCOLX: represents number of collocation points for state variable(s).
%          It has allwas to be a number greater than 0.
%   NCOLU: represents number of collocation points for control variable(s).
%          It can be set as an empty matrix []: if u doesn't belong to the
%          optimised variables and doesn't occure in the objfun, confun,
%          process functions, otherwise, it has allways to be a number
%          greater than 0.
%      LI: represents lengths of time intervals. It has allways to be an
%          ni-by-1 vector.
%      TF: represents the final time. If the value is not specified, use
%          empty brackets [].
%      UI: represents control variables applied on each time interval in
%          li. The same holds here as for ncolu parameter. If control
%          variable is needed it has to be an nu-by-ni matrix, otherwise it
%          is an empty matrix [].
%     PAR: represents time independent parameters. As in ui also here it
%          may have been defined either as np-by-1 vector of time
%          independent parameters or as an empty matrix.
%     BDU: control variables bounds (matrix-[lbu ubu;lbui ubui; ...])
%     BDX: state variables bounds (matrix-[lbx ubx;lbxi ubxi; ...])
%     BDP: bounds to the time independent parameters 
%          (matrix-[lbp ubp;lbpi ubpi; ...])
%  OBJFUN: represents objective function
%  CONFUN: represents constraint function
% PROCESS: represents process function
% OPTIONS: represents options to the optimisation. Used options are
%          DerivativeCheck, Diagnostics, DiffMaxChange, DiffMinChange,
%          Display, GradConstr, GradObj, LargeScale, MaxFunEvals, MaxIter,
%          MaxPCGIter, PrecondBandWidth, TolCon, TolFun, TolPCG, TolX,
%          TypicalX, NLPSolver
%--------------------------------------------------------------------------
%
% output arguments in OPTIMOUT structure:
%--------------------------------------------------------------------------
%     NLPX: the solution found by the optimisation function
%     FVAL: the value of the objective function objfun at the solution NLPX
% EXITFLAG: the exit condition
%   OUTPUT: an output structure that contains information about the results
%           of the optimisation
%   LAMBDA: the Lagrange multipliers at the solution NLPX
%     GRAD: the value of the gradient of objfun at the solution NLPX
%        T: vector of times in which the values of optimal control are
%           printed
%        U: optimal control profile values for vector T
%        P: optimal values of time independent parameters
%--------------------------------------------------------------------------
%==========================================================================
%
%   [OPTIMOUT,OPTIMPARAM] = dynopt(OPTIMPARAM) starts with the initial
%   lengths of intervals OPTIMPARAM.LI, initial control values for each
%   interval OPTIMPARAM.UI for defined number of collocation points for
%   state variables OPTIMPARAM.NCOLX, and for control variables
%   OPTIMPARAM.NCOLU to the final time OPTIMPARAM.TF, and minimises either
%   a Mayer type OPTIMPARAM.OBJFUN evaluated in the final time or Sum type
%   OPTIMPARAM.OBJFUN subject to the nonlinear inequalities or equalities
%   defined in OPTIMPARAM.CONFUN for time $t_0$, $t_f$ or over full time
%   interval characterised by flag in OPTIMPARAM.CONFUN subject to a given
%   system in OPTIMPARAM.PROCESS with the optimisation parameters specified
%   in the structure OPTIMPARAM.OPTIONS, with the defined set of lower and
%   upper bounds on the control variables OPTIMPARAM.BDU, state variables
%   OPTIMPARAM.BDX, and time independent parameters OPTIMPARAM.BDP so that
%   solution is allways in the range of this bounds. All before mentioned
%   variables do entry dynopt in structure OPTIMPARAM. The solution is
%   returned in the otpimout structure OPTIMOUT.  
%
% See also PROFILES, CONSTRAINTS


% testing all inputs
testinputvar(optim_param);

% filling the structure optim_param with appropriate variables
%..........................................................................
% boundary conditions for time 
if (optim_param.optvar == 1 || optim_param.optvar == 3 ...
        || optim_param.optvar == 5 || optim_param.optvar == 7) 
    % time belongs to optimised parameters
    optim_param.bdt = [0.001 sum(optim_param.li)]; 
else
    optim_param.bdt = []; % time doesn't belong to optimised parameters
end

% number of interval estimation
% lengths of intervals are always given, they can but they also don't have
% to belong to optimised variables 
optim_param.ni = length(optim_param.li); 

% number of control varibles estimation
% nu = 0 - if u_init = [], nu > 0 - otherwise
optim_param.nu = size(optim_param.ui,1);

% number of state variables estimation
% nx > 0 always
optim_param.nx = length(feval(optim_param.process,0,0,5,0,optim_param.par)); 

% number of parameters estimation
% np = 0 - if par_init = [], np > 0 - otherwise
optim_param.np = length(optim_param.par);

% collocation points and Lagrange functions estimation
% collocation points for states are always given !!!
tau = [0;legroots(optim_param.ncolx);1]; % collocation points in [0,1]
optim_param.tau = tau;
taukx = [0;legroots(optim_param.ncolx)]; % collocation points in [0,1[
% Lagrange funcitons for states
[optim_param.lfx,optim_param.dlfx] = lagfun(tau,taukx); 

if isempty(optim_param.ncolu) % if control variables are not given
    % the control variables are not given and they also don't belong to 
    % optimised parameters
    tauku = [];
    % Lagrange funcitons for controls
    optim_param.lfu = [];
else % if control variables are given
    % the control variables are given, they can but they also don't have to
    % belong to optimised parameteres
    tauku = legroots(optim_param.ncolu);
    % Lagrange funcitons controls
    optim_param.lfu = lagfun(tau,tauku);
end

% mass matrix estimation
optim_param.M = feval(optim_param.process,0,0,7,0,0); % DAE system
if isempty(optim_param.M)
    optim_param.M = eye(optim_param.nx); % ODE system
end

% filling the optim_param variable with variables dt_col, du_col, dx_col,
% dp_col
[optim_param.dt_col,optim_param.du_col,optim_param.dx_col, ...
    optim_param.dp_col] = isoptimised(optim_param.optvar,optim_param.ncolx, ...
    optim_param.ncolu,optim_param.ni,optim_param.nu,optim_param.nx, ...
    optim_param.np);
%..........................................................................

% initialisation for optimisation
%..........................................................................
% estimation of initial values for the optimisation 
[x0,lb,ub] = initoptimvar(optim_param);

% estimation of linear inequality constraint matrix A and vector b
[A,b] = liniconstr(optim_param);

% estimation of linear equality constraint matrix Aeq and vector beq
[Aeq,beq] = lineqconstr(optim_param);
%..........................................................................

% calculus
%..........................................................................
% obtaining information about gradients
objgr = optimget(optim_param.options,'GradObj');
if (isempty(objgr))
  objgr='off';
  optim_param.options = optimset(optim_param.options,'GradObj','off');
end

congr = optimget(optim_param.options,'GradConstr');
if (isempty(congr))
  congr='off';
  optim_param.options = optimset(optim_param.options,'GradConstr','off');
end

% set default NLP solver
if ~isfield(optim_param.options, 'NLPsolver')
    optim_param.options.NLPsolver = 'fmincon';
end

if (strcmp(optim_param.options.NLPsolver,'ipopt') == 1) && (strcmp(objgr,'on') ~= 1) && (strcmp(congr,'on') ~= 1)
  warning('Gradients are missing, ipopt cannot be used, switching to fmincon.')
  optim_param.options.NLPsolver = 'fmincon';
end


% optimisation
if (strcmp(objgr,'on') == 1) && (strcmp(congr,'on') == 1)
    
    [optimout.nlpx,optimout.fval,optimout.exitflag,optimout.output, ...
        optimout.lambda,optimout.grad,optimout.hessian] = ...
        fminsdp(@(x) cmobjfungrad(x, optim_param),x0,A,b,Aeq,beq,lb,ub,@(x) cmconfungrad(x, optim_param), ...
        optim_param.options);
    
else
        [optimout.nlpx,optimout.fval,optimout.exitflag,optimout.output, ...
        optimout.lambda,optimout.grad,optimout.hessian] = ...
        fminsdp(@(x) cmobjfun(x, optim_param),x0,A,b,Aeq,beq,lb,ub,@(x) cmconfun(x, optim_param), ...
        optim_param.options);
    
end
    
%[x,fval,exitflag,output,lambda,grad,hessian] = ...
%fminsdp(objfun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)

%..........................................................................

% user output from optimisation
%..........................................................................
% initialisation of output variables
optimout.t = []; optimout.u = []; optimout.p =[];

% vector of length of intervals and parameters, and matrixes of control
% and state variable coefficients uij and xij calculus 
[limopt,umopt,xmopt,pmopt] = cmvariables(optimout.nlpx,optim_param);

% t, u calculus
if (optim_param.optvar == 2 || optim_param.optvar == 3 ...
        || optim_param.optvar == 6 || optim_param.optvar == 7)
    % time matrix in collocation points for control variable in interval
    % [t0,tf] first element knot is zeta_0 = 0, next are zeta_i =
    % sum(tek_pom(1:i)) 
    tek_temp = [0;limopt];
    tek = cumsum(tek_temp); 
    
    % ncolu+2-by-ni matrix t over all time interval [t0,tf] for control
    % variables 
    tau = [0;legroots(optim_param.ncolu);1];
    tu = tau*limopt' + ones(length(tau),1)*tek(1:end-1)'; 
    
    % user output for time
    optimout.t = tu(:);
    
    % user otuput for control
    temp = length(tau);
    u = [];
    if ~isempty(umopt)
        for i=1:optim_param.ni
            for j=1:temp
                % nu-by-1 vector
                uj = reshape(umopt(:,i),optim_param.ncolu,optim_param.nu)' ...
                    *optim_param.lfu(j,:)';
                u = [u;uj'];
            end
        end
    end
    optimout.u = u;
end

% p
optimout.p = [pmopt];
%..........................................................................
%--------------------------------------------------------------------------
