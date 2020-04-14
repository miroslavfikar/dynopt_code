clear; close all; clc;
%% Global parameters : 
global x10 x20

% initial conditions :
x10 = 1;
x20 = 0;
     

%% Optimization : 

options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-7,...
                       'TolCon',1e-7,'TolX',1e-7,...
                       'MaxFunEvals',1e5,'MaxIter',1e5,'Algorithm','sqp',...
                       'DerivativeCheck','on','NLPsolver','fmincon');

optimparam.optvar = 3; 
optimparam.objtype = []; 
optimparam.ncolx = 6;
optimparam.ncolu = 2; 
optimparam.li = ones(4,1)*(1/4);
optimparam.tf = 1;
optimparam.ui = ones(1,4)*2.5;
optimparam.par = []; 
optimparam.bdu = [0 5];
optimparam.bdx = []; 
optimparam.bdp =[];
optimparam.objfun  = @objfun;
optimparam.confun  = @confun;
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam] = dynopt(optimparam);
[tplot,uplot,xplot]   = profiles(optimout,optimparam,50);

figure
subplot(1,2,1)
plot(tplot, xplot(:, 1:2))
xlabel('t')
ylabel('x_1, x_2')

subplot(1,2,2)
plot(tplot, uplot)
xlabel('t')
ylabel('u')
