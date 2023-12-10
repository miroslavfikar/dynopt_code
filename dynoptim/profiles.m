function [tplot,uplot,xplot] = profiles(optimout,optim_param,ntimes,ode)
% PROFILES - returns vectors/matrices of time, control and state variables
% prepared to plot them. 
%
%   [TPLOT,UPLOT,XPLOT] = profiles(OPTIMOUT,OPTIM_PARAM,NTIMES,NTIMES)
%   takes the output structures from dynopt function OPTIMOUT and
%   OPTIM_PARAM containing all information about optimisation, and a value
%   of points NTIMES representing a density of ploting points for each
%   interval, and returns m-by-1 time vector TPLOT, and m-by-nu control
%   matrix UPLOT, and m-by-nx state matrix XPLOT, where m represets value
%   of (ntimes+1)*ni, nu represents number of control variables, and nx
%   represents number of state variables.
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
[lim,um,xm,pm] = cmvariables(optimout.nlpx,optim_param);

% time matrix in all collocation points in interval [t0,tf]
% tfull = coltime(optim_param,lim);
%..........................................................................
% first element knot is zeta_0 = 0, next are zeta_i = sum(tek_pom(1:i))
tek_temp = [0;lim];
tek = cumsum(tek_temp); 

% ntimes+1-by-ni matrix t over all time interval [t0,tf]
tfull = tau*lim' + ones(length(tau),1)*tek(1:end-1)'; 
%..........................................................................

% time, control and state variables calculation
temp = length(tau);
tplot = zeros(optim_param.ni*temp,1);
uplot = zeros(optim_param.ni*temp,optim_param.nu);
xplot = zeros(optim_param.ni*temp,optim_param.nx);
for i=1:optim_param.ni
    for j=1:temp
        if ~isempty(um)
            % nu-by-1 vector
            uj = reshape(um(:,i),optim_param.ncolu,optim_param.nu)'*lfu(j,:)';
            uplot((i-1)*temp+j,:) = uj';
        end
        % nx-by-1 vector
        tplot((i-1)*temp+j) = tfull(j,i);
        % solution from collocation points
        xj = reshape(xm(:,i),optim_param.ncolx+1,optim_param.nx)'*lfx(j,:)';
        xplot((i-1)*temp+j,:) = xj';      
        %        if isempty(optim_param.ui)
        %    uj = [];
        %end
        %[t,y] = ode23t(optim_param.origprocess,tfull(j,i)',y0,odeop,0,uj,optimout.p);
        %xp_temp = y(1:optim_param.ncolx+1,:);
        %xplot((i-1)*temp+j,:) = xp_temp;      
        %y0 = y(end,:);

    end
end

if exist('ode')
    % solution from integration
    % piece-wise constant u is assumed between 2 printing times
    xplot1 = zeros(optim_param.ni*temp,optim_param.nx);
    y0 = feval(optim_param.origprocess,0,0,5,0,optimout.p);
    odeop = odeset('Mass',optim_param.M,'MassSingular','maybe','RelTol',1e-13);
    n = length(tplot);
    xplot1(1,:) = y0';
    for i=1:n-1
        if isempty(optim_param.ui)
            uj = [];
        else
            uj = uplot(i,:);
        end
        if tplot(i) ~= tplot(i+1)
            [t,y] = ode23t(optim_param.origprocess,[tplot(i), tplot(i+1)],y0,odeop,0,uj,optimout.p);
        end
        xplot1(i+1,:) = y(end,:);
        y0 = y(end,:);
    end
    % compare both solutions
    % max(abs(xplot-xplot1))
    
    xplot = xplot1;
end

end

