clc; clear all; close all;

options = sdpoptionset('LargeScale', 'on', 'Display', 'iter', 'TolFun', 1e-7, ...
    'TolCon', 1e-7, 'TolX',1e-7, 'MaxFunEvals', 1e6, ...
    'MaxIter', 4000, 'Algorithm', 'sqp', 'NLPsolver', 'fmincon');
optimparam.optvar     = 3;
optimparam.objtype    = [];
optimparam.ncolx      = 4;
optimparam.ncolu      = 2;
optimparam.li         = ones(10,1)*.3;
optimparam.tf         = 15;
optimparam.ui         = zeros(1,10);
optimparam.par        = [];
optimparam.bdu        = [0 2.5];
optimparam.bdx        = [0 3; 0 3; 0 4; 0 10; 0.5 25];
optimparam.bdp        = [];
optimparam.objfun     = @objfun;
optimparam.confun     = @confun;
optimparam.process    = @process;
optimparam.options    = options;
[optimout,optimparam] = dynopt(optimparam)

save optimresults optimout optimparam
[tplot,uplot,xplot] = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot