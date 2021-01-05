function [tplot,cplot,ceqplot] = constraints(optimout,optim_param,ntimes,ode)
% CONSTRAINTS - returns vector of time, vectors/matrices of nonlinear
% inequality and equality contraint introduced over full time interval
% [t0,tf] prepared to plot them.   
%
%   [TPLOT,CPLOT,CEQPLOT] = constraints(OPTIMOUT,OPTIM_PARAM,NTIMES) takes the
%   output structures from dynopt function OPTIMOUT and OPTIM_PARAM
%   containing all information about optimisation, and a value of points
%   NTIMES representing a density of ploting points for each interval, and
%   returns m-by-1 time vector TPLOT, and m-by-n nolninear inequality
%   constraint matrix CPLOT, and m-by-p nonlinear equality constraint
%   matrix CEQPLOT, where m represets value of (ntimes+1)*ni, n represents
%   number of nonlinear inequality constraints, and p represents number of
%   nonlinear equality constraints.
%   Optional parameter ODE specifies that states are calculated
%   using ODE solvers instead of default approximation by
%   collocation polynomials


% collocation points and Lagrange functions estimation
% collocation points for states are always given !!!
tau  = [0:1/ntimes:1]'; % printing points
taukx = [0;legroots(optim_param.ncolx)]; % collocation points in [0,1[
[lfx,dlfx] = lagfun(tau,taukx); % Lagrange functions for states

if isempty(optim_param.ncolu) % if control variables are not given
    % the control variables are not given and they also don't belong to 
    % optimised parameters
    tauku = [];
    lfu = [];
else % if control variables are given
    % the control variables are given, they can but they also don't have to
    % belong to optimised parameteres
    tauku = legroots(optim_param.ncolu); 
    lfu = lagfun(tau,tauku);
end

% vector of length of intervals and parameters, and matrices of control and
% state variable coefficients uij and xij calculus 
[limopt,umopt,xmopt,pmopt] = cmvariables(optimout.nlpx,optim_param);

% time matrix in all collocation points in interval [t0,tf]
%..........................................................................
% first element knot is zeta_0 = 0, next are zeta_i = sum(tek_pom(1:i))
tek_temp = [0;limopt];
tek = cumsum(tek_temp); 

% ntimes+1-by-ni matrix t over all time interval [t0,tf]
tfull = tau*limopt' + ones(length(tau),1)*tek(1:end-1)'; 
%..........................................................................

% t, c, ceq variables calculation
temp = length(tau);
tplot = zeros(optim_param.ni*temp,1);
uplot = zeros(optim_param.ni*temp,optim_param.nu);
cplot = [];
ceqplot = [];
for i=1:optim_param.ni
    for j=1:temp
        tplot((i-1)*temp+j) = tfull(j,i);
        % nu-by-1 vector
        uj = reshape(umopt(:,i),optim_param.ncolu,optim_param.nu)'*lfu(j,:)'; 
        % nx-by-1 vector
        xj = reshape(xmopt(:,i),optim_param.ncolx+1,optim_param.nx)'*lfx(j,:)';
        % np-by-1 vector
        pj = pmopt;
        % user defined constraints   
        [uc,uceq]=feval(optim_param.confun,tfull(j,i),xj,1,uj,pj, optim_param);
        cplot = [cplot;uc];
        ceqplot = [ceqplot;uceq];
        uplot((i-1)*temp+j,:) = uj';
    end
end

if exist('ode')
    % solution from integration
    % piece-wise constant u is assumed between 2 printing times
    y0 = feval(optim_param.origprocess,0,0,5,0,optim_param.par);
    odeop = odeset('Mass',optim_param.M,'MassSingular','maybe','RelTol',1e-13);
    n = length(tplot);
    xplot = y0';
    cplot1 = [];
    ceqplot1 = [];
    for i=1:n-1
        if isempty(optim_param.ui)
            uj = [];
        else
            uj = uplot(i,:);
        end
        if tplot(i) ~= tplot(i+1)
            [t,y] = ode23t(optim_param.origprocess,[tplot(i), tplot(i+1)],y0,odeop,0,uj,optim_param.par);
        end
        y0 = y(end,:);
        [uc,uceq]=feval(optim_param.confun,tplot(i),xplot,1,uj,pj, optim_param);
        cplot1 = [cplot1;uc];
        ceqplot1 = [ceqplot1;uceq];
        xplot = y0';
        
    end
    [uc,uceq]=feval(optim_param.confun,tplot(n),xplot,1,uj,pj, optim_param);
    cplot1 = [cplot1;uc];
    ceqplot1 = [ceqplot1;uceq];

    % compare both solutions
    % max(abs(cplot-cplot1)), max(abs(ceqplot-ceqplot1))
    
    cplot = cplot1;
    ceqplot = ceqplot1;
end

end

