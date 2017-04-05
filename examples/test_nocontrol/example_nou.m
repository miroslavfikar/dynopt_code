clear; close all; clc;

% global variables :
global p_vab x0

% parameters :
p_vab = 5;
x0    = 9;

% Optimization : 
options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-4,...
                       'TolCon',1e-4,'TolX',1e-4,...
                       'MaxFunEvals',1e5,'Algorithm','sqp',...
                       'DerivativeCheck','on','GradObj','on',...
                       'GradConstr','on','NLPsolver','fmincon');

optimparam.optvar = 1;
optimparam.objtype = [];
optimparam.ncolx = 9; 
optimparam.ncolu = []; 
optimparam.li = ones(2,1);
optimparam.tf = [];
optimparam.ui = [];
optimparam.par = []; 
optimparam.bdu = []; 
optimparam.bdx = [-500 500]; 
optimparam.bdp = [];
optimparam.objfun  = @objfun;
optimparam.confun  = @confun;
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam] = dynopt(optimparam);
[tplot,uplot,xplot]   = profiles(optimout,optimparam,50);

figure
plot(tplot, xplot)
xlabel('t')
ylabel('x')