function [x0,lb,ub] = initoptimvar(optim_param)
% INITOPTIMVAR - returns the initial vector x0, and boundary vectors lb and
% ub to the NLP solver fmincon.

% This function is used in dynopt function.


% vector x0
%..........................................................................
% time in all collocation points for state variables over interval [t0,tf]
tfull = coltime(optim_param.tau,optim_param.li); 

% initialisation of integration x(t0) = x_0
y0 = feval(optim_param.process,0,0,5,0,optim_param.par);

% mass matrix estimation
M = optim_param.M;

xp = [];                               
up = [];
odeop = odeset('Mass',M,'MassSingular','maybe','RelTol',1e-5);

% integration of process function
for i=1:optim_param.ni
    % condition for control variable
    if isempty(optim_param.ui)
        ui = [];
    else
        ui = optim_param.ui(:,i);
    end
    
    % integration
    [t,y] = ode23t(optim_param.process,tfull(:,i)',y0,odeop,0,ui,optim_param.par);
    xp_temp = y(1:optim_param.ncolx+1,:);
    xp = [xp; xp_temp(:)];
    if ~isempty(optim_param.ui)
        up_temp = ones(optim_param.ncolu,1)*ui';
        up = [up;up_temp(:)];
    end
    y0 = y(end,:);
end

% output: vector of optimised variables x0
switch optim_param.optvar
    case 1 % optimised variables: t,x
        x0 = [optim_param.li;xp]; 
    case 2 % optimised variables: u,x
        x0 = [up;xp]; 
    case 3 % optimised variables: t,u,x
        x0 = [optim_param.li;up;xp]; 
    case 4 % optimised variables: x,p
        x0 = [xp;optim_param.par]; 
    case 5 % optimised variables: t,p
        x0 = [optim_param.li;xp;optim_param.par];
    case 6 % optimised variables: u,x,p
        x0 = [up;xp;optim_param.par]; 
    case 7 % optimised variables: t,u,x,p
        x0 = [optim_param.li;up;xp;optim_param.par]; 
    otherwise
        errmsg = sprintf('%s %s', ...
            'Incorrect use of function initoptimvar: ', ...
            'parameter OPTVAR must be a number between 1 and 7');
        error(errmsg);
end
%..........................................................................

% lower and upper bounds for vector x0
%..........................................................................
mlbt=[];mubt=[];
mlbu=[];mubu=[];
mlbx=[];mubx=[];
mlbp=[];mubp=[];

for i=1:optim_param.ni
    % lower/upper bounds for t
    % they are calculated just when t belongs to optimised variables
    if (optim_param.optvar == 1 || optim_param.optvar == 3 ...
            || optim_param.optvar == 5 || optim_param.optvar == 7) 
        lbt = optim_param.bdt(1,1);
        mlbt = [mlbt;lbt];
        ubt = optim_param.bdt(1,2);
        mubt = [mubt;ubt];
    end
    
    % lower/upper bounds for u
    % they are calculated just when u belongs to optimised variables
    if (optim_param.optvar == 2 || optim_param.optvar == 3 ...
            || optim_param.optvar == 6 || optim_param.optvar == 7) 
        if isempty(optim_param.bdu)
            lbu = (-inf*ones(optim_param.nu,1)*ones(1,optim_param.ncolu))';
            ubu = (inf*ones(optim_param.nu,1)*ones(1,optim_param.ncolu))';
        elseif (size(optim_param.bdu,2) == 2)            
            lbu = (optim_param.bdu(:,1)*ones(1,optim_param.ncolu))';
            ubu = (optim_param.bdu(:,2)*ones(1,optim_param.ncolu))';
        else  
            lbu = (optim_param.bdu(:,(i-1)+i)*ones(1,optim_param.ncolu))';
            ubu = (optim_param.bdu(:,2*i)*ones(1,optim_param.ncolu))';
        end
        lbu = lbu(:);
        mlbu = [mlbu;lbu];
        ubu = ubu(:);
        mubu = [mubu;ubu];
    end
            
    % lower/upper bounds for x
    % they are calculated always
    if isempty(optim_param.bdx)
        lbx = (-inf*ones(optim_param.nx,1)*ones(1,optim_param.ncolx+1))';
        ubx = (inf*ones(optim_param.nx,1)*ones(1,optim_param.ncolx+1))';
    elseif size(optim_param.bdx,2) == 2
        lbx = (optim_param.bdx(:,1)*ones(1,optim_param.ncolx+1))';
        ubx = (optim_param.bdx(:,2)*ones(1,optim_param.ncolx+1))';
    else 
        lbx = (optim_param.bdx(:,(i-1)+i)*ones(1,optim_param.ncolx+1))';
        ubx = (optim_param.bdx(:,2*i)*ones(1,optim_param.ncolx+1))';
    end
    lbx = lbx(:);
    mlbx = [mlbx;lbx];
    ubx = ubx(:);
    mubx = [mubx;ubx];  
end

% lower/upper bounds for p
% they are calculated just when p belongs to optimised variables
if (optim_param.optvar == 4 || optim_param.optvar == 5 ...
        || optim_param.optvar == 6 || optim_param.optvar == 7)
    if isempty(optim_param.bdp)
        mlbp = (-inf*ones(optim_param.np,1));
        mubp = (inf*ones(optim_param.np,1));
    else
        mlbp = optim_param.bdp(:,1);
        mubp = optim_param.bdp(:,2);
    end
end

% output: vectors of lower and upper bounds to optimised vector x0
lb=[mlbt;mlbu;mlbx;mlbp];
ub=[mubt;mubu;mubx;mubp];
%..........................................................................
% fix x0 to be between [lb, ub] - numerics from ODE integration
% is sometimes slightly outside
ii = find (x0 < lb);
x0(ii) = lb(ii);
ii = find (x0 > ub);
x0(ii) = ub(ii);
end

%--------------------------------------------------------------------------