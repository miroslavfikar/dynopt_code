clear all; clc; close all;
 
options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-7,...
                       'TolCon',1e-7,'TolX',1e-7,...
                       'MaxFunEvals',1e5,'MaxIter',4000,'Algorithm','sqp',...
                       'NLPsolver','fmincon');
optimparam.optvar = 3;
optimparam.objtype = [];
optimparam.ncolx = 3;
optimparam.ncolu = 2;
optimparam.li = ones(10,1)*(100);
optimparam.tf = 1000;
optimparam.ui = ones(1,10)*273;
optimparam.par = [];
optimparam.bdu = [273 415];
optimparam.bdx = [];
optimparam.bdp = [];
optimparam.objfun  = @objfun;
optimparam.confun  = @confun;
optimparam.process = @process;
optimparam.options = options;
[optimout, optimparam] = dynopt(optimparam);
[tplot,uplot,xplot]    = profiles(optimout,optimparam,50);
[tp,cp,ceqp] = constraints(optimout,optimparam,50);


