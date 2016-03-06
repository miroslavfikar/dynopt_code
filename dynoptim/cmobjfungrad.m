function [cmf,cmDf] = cmobjfungrad(nlpx,optim_param)
% CMOBJFUNGRAD - returns to the NLP solver fmincon the value of user
% defined objective function CMF and its gradients with respect to all
% optimised variables (li, uij, xij, par) CMDF evaluated at final time tf.

% This function is used in dynopt function.


% objective function
cmf = [];
cmDf = [];

% vector of length variables and parameters, and matrixes of control and
% state varibale coefficients uij and xij calculus
[lim,um,xm,pm] = cmvariables(nlpx,optim_param);

% time matrix in all collocation points in interval [t0,tf]
tfull = coltime(optim_param.tau,lim);

if isempty(optim_param.objtype) % user defined objective function in tf
    [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm, ...
        optim_param.ni,optim_param.ncolx+2);
    [Uf,DUf] = userperformindx(optim_param,t_c,x_c,u_c,p_c, ...
        optim_param.ni,optim_param.ncolx+2);
    cmf = [cmf;Uf];
    cmDf = [cmDf;DUf];
    cmDf = cmDf';
else % user defined objective function for parameter estimation
    [pf,pDf] = paramperformindx(tfull,xm,um,pm,optim_param);
    cmf = pf;
    cmDf = pDf';
end
%--------------------------------------------------------------------------