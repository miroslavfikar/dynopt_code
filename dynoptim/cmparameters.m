function optim_param = cmparameters(optvar,objtype,ncolx,ncolu,li_init,u_init,p_init,objfun,confun,process)
% CMPARAMETERS -


% calculus
optim_param.optvar = optvar;
optim_param.objtype = objtype;
optim_param.ncolx = ncolx;
optim_param.ncolu = ncolu;
optim_param.li = li_init;
optim_param.ui = u_init;
optim_param.par = p_init;
optim_param.objfun = objfun;
optim_param.confun = confun;
optim_param.process = process;

% number of interval estimation
% lengths of intervals are always given, they can but they also don't have
% to belong to optimised variables 
ni = length(li_init); 
optim_param.ni = ni;

% number of control varibles estimation
% nu = 0 - if u_init = [], nu > 0 - otherwise
nu = size(u_init,1);
optim_param.nu = nu;

% number of state variables estimation
% nx > 0 always
nx = length(feval(process,0,0,5,0,p_init)); 
optim_param.nx = nx;

% number of parameters estimation
% np = 0 - if par_init = [], np > 0 - otherwise
np = length(p_init);
optim_param.np = np;

% collocation points and Lagrange functions estimation
% collocation points for states are always given !!!
tau = [0;legroots(ncolx);1]; % collocation points in [0,1]
optim_param.tau = tau;
taukx = [0;legroots(ncolx)]; % collocation points in [0,1[
[optim_param.lfx,optim_param.dlfx] = lagfun(tau,taukx); % Lagrange funcitons for states

if isempty(ncolu) % if control variables are not given
    % the control variables are not given and they also don't belong to 
    % optimised parameters
    tauku = [];
    optim_param.lfu = [];
else % if control variables are given
    % the control variables are given, they can but they also don't have to
    % belong to optimised parameteres
    tauku = legroots(ncolu); 
    optim_param.lfu = lagfun(tau,tauku);
end

% mass matrix estimation
M = feval(process,0,0,7,0,0); % DAE system
if isempty(M)
    M = eye(nx); % ODE system
end
optim_param.M = M;

% filling the optim_param variable with variables dt_col, du_col, dx_col,
% dp_col
[optim_param.dt_col,optim_param.du_col,optim_param.dx_col,optim_param.dp_col] = isoptimised(optvar,ncolx,ncolu,ni,nu,nx,np);
%--------------------------------------------------------------------------