function [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm,i,j)
% EVALCOLLPOINT - returns the real collocation time T_C, state vector X_C,
% control vector U_C, and vector of parameters P_C evaluated in each
% collocation time T_C.

% This function is used in cmconfun, cmconfungrad, cmobjfun, cmobjfungrad,
% nonlineqconstr functions.


% t_c - time in given collocation point
t_c = tfull(j,i);

% x_c - state variables in given collocation point
x_c = reshape(xm(:,i),optim_param.ncolx+1,optim_param.nx)'*optim_param.lfx(j,:)';

% u_c - control variables in given collocation point
if ~isempty(um)
    u_c = reshape(um(:,i),optim_param.ncolu,optim_param.nu)'*optim_param.lfu(j,:)';
else
    u_c = [];
end

% p_c - parameters in collocation point
if ~isempty(pm)
    p_c = pm;
else
    p_c = [];
end
%--------------------------------------------------------------------------