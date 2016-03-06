function [cmc,cmceq,cmDc,cmDceq] = cmconfungrad(nlpx,optim_param)
% CMCONFUNGRAD - returns to the NLP solver fmincon the values of nonlinear
% constraint inequalities CMC and equalities CMCEQ, both CMC anc CMCEQ are
% vectors. 

% This function is used in dynopt function.


% initialisation of variables
%..........................................................................
% inequality constraints
cmc = [];
% gradients of inequality constraints with respect to all optimised
% variables
cmDc = [];
% equality constraints
cmceq = [];
% gradients of equality constraints with respect to all optimised variables
cmDceq = [];
%..........................................................................

% vector of length variables and parameters, and matrixes of control and
% state varibale coefficients uij and xij calculus
[lim,um,xm,pm] = cmvariables(nlpx,optim_param);

% time matrix in all collocation points in interval [t0,tf]
tfull = coltime(optim_param.tau,lim);

% nonlinear equality constraints given by orthogonal collocation method
[Mceq,DMceq] = nonlineqconstr(optim_param,lim,um,xm,pm,tfull);
cmceq = [cmceq;Mceq];
cmDceq = [cmDceq;DMceq];

% user defined constraints
if ~isempty(optim_param.confun)
    % constraints in t0
    %......................................................................
    [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm,1,1);
    [Uc,Uceq,DUc,DUceq] = userconst(optim_param,t_c,x_c,0,u_c,p_c,1,1);
    cmc = [cmc;Uc];
    cmceq = [cmceq;Uceq];
    cmDc = [cmDc;DUc];
    cmDceq = [cmDceq;DUceq];
    %......................................................................
    
    % constraints over full time interval [t0,tf]
    %......................................................................
    for i = 1:optim_param.ni
        for j = 1:optim_param.ncolx+1
            [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm,i,j);
            [Uc,Uceq,DUc,DUceq] = userconst(optim_param,t_c,x_c,1,u_c,p_c,i,j);
            cmc = [cmc;Uc];
            cmceq = [cmceq;Uceq];
            cmDc = [cmDc;DUc];
            cmDceq = [cmDceq;DUceq];
        end
        if i == optim_param.ni
            [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm,i, ...
                optim_param.ncolx+2);
            [Uc,Uceq,DUc,DUceq] = userconst(optim_param,t_c,x_c,1,u_c,p_c,i, ...
                optim_param.ncolx+2);
            cmc = [cmc;Uc];
            cmceq = [cmceq;Uceq];
            cmDc = [cmDc;DUc];
            cmDceq = [cmDceq;DUceq];
        end
    end
    %......................................................................
    
    % constraints in tf
    %......................................................................
    [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm, ...
        optim_param.ni,optim_param.ncolx+2);
    [Uc,Uceq,DUc,DUceq] = userconst(optim_param,t_c,x_c,2,u_c,p_c, ...
        optim_param.ni,optim_param.ncolx+2);
    cmc = [cmc;Uc];
    cmceq = [cmceq;Uceq];
    cmDc = [cmDc;DUc];
    cmDceq = [cmDceq;DUceq];
    %......................................................................
end
cmDc = cmDc';
cmDceq = cmDceq';
%--------------------------------------------------------------------------