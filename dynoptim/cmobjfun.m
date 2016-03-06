function [cmf] = cmobjfun(nlpx,optim_param)
% CMOBJFUN - returns to the NLP solver fmincon the value of user defined
% objective function CMF evaluated at final time tf.

% This function is used in dynopt function.


% objective function
cmf = [];

% vector of length variables and parameters, and matrixes of control and
% state varibale coefficients uij and xij calculus
[lim,um,xm,pm] = cmvariables(nlpx,optim_param);

% time matrix in all collocation points in interval [t0,tf]
tfull = coltime(optim_param.tau,lim);

if isempty(optim_param.objtype) % user defined objective function in tf
    [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm, ...
        optim_param.ni,optim_param.ncolx+2);
    [Uf] = userperformindx(optim_param,t_c,x_c,u_c,p_c,optim_param.ni, ...
        optim_param.ncolx+2);
    cmf = [cmf;Uf];
else % user defined objective function for parameter estimation
    pf = paramperformindx(tfull,xm,um,pm,optim_param);
    cmf = pf;
end
%--------------------------------------------------------------------------