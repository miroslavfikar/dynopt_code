function [cmc,cmceq] = cmconfun(nlpx,optim_param)
% CMCONFUN - returns to the NLP solver fmincon the values of nonlinear
% constraint inequalities CMC and equalities CMCEQ, both CMC and CMCEQ are
% vectors. 

% This function is used in dynopt function.


% inequality constraints
cmc = [];
% equality constraints
cmceq = [];

% vector of length variables and parameters, and matrixes of control and
% state varibale coefficients uij and xij calculus
[lim,um,xm,pm] = cmvariables(nlpx,optim_param);

% time matrix in all collocation points in interval [t0,tf]
tfull = coltime(optim_param.tau,lim);

% nonlinear equality constraints given by orthogonal collocation method
Mceq = nonlineqconstr(optim_param,lim,um,xm,pm,tfull);
cmceq = [cmceq;Mceq];

% user defined constraints
if ~isempty(optim_param.confun)
    % constraints in t0
    [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm,1,1);
    [Uc,Uceq] = userconst(optim_param,t_c,x_c,0,u_c,p_c,1,1);
    cmc = [cmc;Uc];
    cmceq = [cmceq;Uceq];
    
    % constraints over full time interval [t0,tf]
    for i = 1:optim_param.ni
        for j = 1:optim_param.ncolx+1
            [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm,i,j);
            [Uc,Uceq] = userconst(optim_param,t_c,x_c,1,u_c,p_c,i,j);
            cmc = [cmc;Uc];
            cmceq = [cmceq;Uceq];
        end
        if i == optim_param.ni
            [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm, ...
                i,optim_param.ncolx+2);
            [Uc,Uceq] = userconst(optim_param,t_c,x_c,1,u_c,p_c,i, ...
                optim_param.ncolx+2);
            cmc = [cmc;Uc];
            cmceq = [cmceq;Uceq];
        end
    end
    
    % constraints in tf
    [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm, ...
        optim_param.ni,optim_param.ncolx+2);
    [Uc,Uceq] = userconst(optim_param,t_c,x_c,2,u_c,p_c,optim_param.ni, ...
        optim_param.ncolx+2);
    cmc = [cmc;Uc];
    cmceq = [cmceq;Uceq];
end
%--------------------------------------------------------------------------