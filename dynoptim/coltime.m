function [t,tek] = coltime(tau,lim)
% COLTIME - returns values representing times in collocation points over
% full interval [t0,tf] and values representing times in element knots.

% This function is used in initoptimvar, cmconfun, cmconfungrad, cmobjfun
% and cmobjfungrad functions.


% first element knot is zeta_0 = 0, next are zeta_i = sum(tek_pom(1:i))
tek_temp = [0;lim];
tek = cumsum(tek_temp); 

% ncol+2-by-ni matrix t over all time interval [t0,tf]
t = tau*lim' + ones(length(tau),1)*tek(1:end-1)'; 
%--------------------------------------------------------------------------