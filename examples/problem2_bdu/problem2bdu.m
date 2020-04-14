clear; close all; clc;
%% Global parameters : 
global x10 x20 x30 x40

% initial conditions :
x10 = 0;
x20 = -1;
x30 = -sqrt(5);
x40 = 0;


% optimization
options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-7,...
                       'TolCon',1e-7,'TolX',1e-7,...
                       'MaxFunEvals',1e5,'MaxIter',1e5,'Algorithm','sqp',...
                       'DerivativeCheck','on','NLPsolver','fmincon');

optimparam.optvar = 3;
optimparam.objtype = [];
optimparam.ncolx = 6; 
optimparam.ncolu = 2; 
optimparam.li = ones(4,1)*(1/4);
optimparam.ui = ones(1,4)*7;
optimparam.tf = 1;
optimparam.par = []; 
optimparam.bdu = [-4 9 -4 10 -4 10 -4 10]; 
optimparam.bdx = []; 
optimparam.bdp = [];
optimparam.objfun  = @objfun;
optimparam.confun  = @confun;
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam] = dynopt(optimparam);
[tplot,uplot,xplot]   = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot 


figure
subplot(2,1,1)
plot(tplot, xplot(:,1:3))
xlabel('t')
ylabel('x_1, x_2, x_3')

subplot(2,1,2)
plot(tplot, uplot)
xlabel('t')
ylabel('u')
