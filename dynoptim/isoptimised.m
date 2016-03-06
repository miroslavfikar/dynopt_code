function [dtcol,ducol,dxcol,dpcol] = isoptimised(optvar,ncolx,ncolu,ni,nu,nx,np)
% ISOPTIMISED - returns the information about optimised variables as the
% number of columns in gradient matrixes for each optimised variable (DTCOL
% (if t is not optimised DTCOL = 0), DUCOL (if u is not optimised DUCOL =
% 0), DXCOL (if x is not optimised DXCOL = 0), DPCOL (if p is not optimised
% DPCOL = 0)).

% This function is used in dynopt function.


% calculation of variations of optimisated variables
% if given variable belongs to optimised variables, the information about
% columns of matrixes Axy, Aeqxy, Dcxy, Dceqxy, ... will be returned
%..........................................................................
% information about interval lengths
if (optvar == 1 || optvar == 3 || optvar == 5 || optvar == 7) % t
    dtcol = ni; % interval lengths are optimised
else
    dtcol = 0; % interval lengths are not optimised
end

% information about control variables
if (optvar == 2 || optvar == 3 || optvar == 6 || optvar == 7) % u
    ducol = ncolu*nu*ni; % control variables are optimised
else
    ducol = 0; % control variables are not optimised
end

% information about state variables
dxcol = (ncolx+1)*nx*ni; % state variables are always optimised

% information about parameters
if (optvar == 4 || optvar == 5 || optvar == 6 || optvar == 7) % p
    dpcol = np; % parameters are optimised
else
    dpcol = 0; % parameters are not optimised
end
%..........................................................................
%--------------------------------------------------------------------------