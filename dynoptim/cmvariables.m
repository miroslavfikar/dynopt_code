function [lim,um,xm,pm] = cmvariables(nlpx,optim_param)
% CMVARIABLES - returns the matrixes filled with variables given by the
% orthogonal collocation method.

% This function is used in cmobjfun, cmobjfungrad, cmconfun, cmconfungrad
% functions.


% separation of optimised vector x into ni-by-1 vector lim_opt,
% ncolu*nu-by-ni matrix um_opt, (ncolx+1)*nx matrix xm_opt, and np-by-1
% vector pm_opt
[lim_opt,um_opt,xm_opt,pm_opt] = separoptimvar(nlpx,optim_param);

% lim vector filling with the right values
% t is not optimised variable and length of intervals are given
if (isempty(lim_opt) && ~isempty(optim_param.li)) 
        lim = optim_param.li;
else  
    lim = lim_opt;
end

% um vector filling with the right values
% u is not optimised variable and  u is given
if (isempty(um_opt) && ~isempty(optim_param.ui))
    % calculus of collocation point variables uij
    um = zeros(optim_param.ncolu*optim_param.nu,optim_param.ni);
    for i = 1:optim_param.ni %
        um_temp = (optim_param.ui(:,i)*ones(1,optim_param.ncolu))';
        um(:,i) = um_temp(:);
    end    
else 
    um = um_opt;
end

% um vector filling with the right values
xm = xm_opt;

% pm vector filling with the right values
% p is not ovptimised variable and p is given
if (isempty(pm_opt) && ~isempty(optim_param.par))
    pm = optim_param.par;
else
    pm = pm_opt;
end
%--------------------------------------------------------------------------


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [lim_opt,um_opt,xm_opt,pm_opt] = separoptimvar(nlpx,optim_param)
% SEPAROPTIMVAR - separates the optimisation variables LI, U, X, P from
% the optimised vector NLPX.


% initialisation of variables
liv = []; uv = []; xv = []; pv = [];

% separation of vectors li, up, xp, par from optimised vector x
%..........................................................................
switch optim_param.optvar
    case 1 % optimised variables: t,x     | x = [li;xij]; 
        liv = nlpx(1:optim_param.ni); lt = length(liv);
        xv = nlpx(lt+1:lt+(optim_param.ncolx+1)*optim_param.nx*optim_param.ni);
        
    case 2 % optimised variables: u,x     | x = [uij;xij]; 
        uv = nlpx(1:optim_param.ncolu*optim_param.nu*optim_param.ni);
        lu = length(uv);
        xv = nlpx(lu+1:lu+(optim_param.ncolx+1)*optim_param.nx*optim_param.ni);
        
    case 3 % optimised variables: t,u,x   | x = [li;uij;xij]; 
        liv = nlpx(1:optim_param.ni); 
        lt = length(liv);
        uv = nlpx(lt+1:lt+optim_param.ncolu*optim_param.nu*optim_param.ni);
        lu = length(uv);
        xv = nlpx(lt+lu+1:lt+lu+(optim_param.ncolx+1)*optim_param.nx*optim_param.ni);
        
    case 4 % optimised variables: x,p     | x = [xij;par]; 
        xv = nlpx(1:(optim_param.ncolx+1)*optim_param.nx*optim_param.ni);
        lx = length(xv);
        pv = nlpx(lx+1:lx+optim_param.np);
        
    case 5 % optimised variables: t,p     | x = [li;xij;par];
        liv = nlpx(1:optim_param.ni);
        lt = length(liv);
        xv = nlpx(lt+1:lt+(optim_param.ncolx+1)*optim_param.nx*optim_param.ni);
        lx = length(xv);
        pv = nlpx(lt+lx+1:lt+lx+optim_param.np);
        
    case 6 % optimised variables: u,x,p   | x = [uij;xij;par]; 
        uv = nlpx(1:optim_param.ncolu*optim_param.nu*optim_param.ni);
        lu = length(uv);
        xv = nlpx(lu+1:lu+(optim_param.ncolx+1)*optim_param.nx*optim_param.ni);
        lx = length(xv);
        pv = nlpx(lu+lx+1:lu+lx+optim_param.np);
        
    case 7 % optimised variables: t,u,x,p | x = [li;uij;xij;par]; 
        liv = nlpx(1:optim_param.ni);
        lt = length(liv);
        uv = nlpx(lt+1:lt+optim_param.ncolu*optim_param.nu*optim_param.ni);
        lu = length(uv);
        xv = nlpx(lt+lu+1:lt+lu+(optim_param.ncolx+1)*optim_param.nx*optim_param.ni);
        lx = length(xv);
        pv = nlpx(lt+lu+lx+1:lt+lu+lx+optim_param.np);
end
%..........................................................................

% calculus of matrixes from vectors liv, upv, xpv, parv obtained by
% separating the optimised vector x, output
%..........................................................................
lim_opt = liv; % optimised variable: li

if ~isempty(uv) % optimised variable: u
    um_opt = reshape(uv,optim_param.ncolu*optim_param.nu,optim_param.ni);
else
    um_opt = uv;
end

if ~isempty(xv) % optimised variable: x
    xm_opt = reshape(xv,(optim_param.ncolx+1)*optim_param.nx,optim_param.ni);
else
    xm_opt = xv;
end

pm_opt = pv; % optimised variable: par
%..........................................................................
%--------------------------------------------------------------------------