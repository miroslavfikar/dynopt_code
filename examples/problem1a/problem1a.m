clear all; close all; clc;
options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-7,...
                       'TolCon',1e-7,'TolX',1e-7,...
                       'MaxFunEvals',1e6,'MaxIter',4000,...
                       'Algorithm','sqp','NLPsolver','fmincon');

optimparam.optvar = 3;
optimparam.objtype = [];
optimparam.ncolx = 3; 
optimparam.ncolu = 2; 
optimparam.li = ones(3,1)*(1/3);
optimparam.tf = 1;
optimparam.ui = zeros(1,3);
optimparam.par = []; 
optimparam.bdu = []; 
optimparam.bdx = []; 
optimparam.bdp = [];
optimparam.objfun  = @objfun;
optimparam.confun  = [];
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam] = dynopt(optimparam);
save optimresults optimout optimparam
[tplot,uplot,xplot] = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot 

figure
subplot(2,1,1); plot(tplot, xplot); xlabel('t'); ylabel('x')
subplot(2,1,2); plot(tplot, uplot); xlabel('t'); ylabel('u')