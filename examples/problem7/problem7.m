clear; close all; clc;
%% Global parameters : 
global x10 x20 x30 x40 x50 x60 x70 x80

% initial conditions :
x10 = 0.1883;
x20 = 0.2507;
x30 = 0.0467;
x40 = 0.0899;
x50 = 0.1804;
x60 = 0.1394;
x70 = 0.1046;
x80 = 0;
      

%% Optimization : 

options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-7,...
                       'TolCon',1e-7,'TolX',1e-7,...
                       'MaxFunEvals',1e5,'MaxIter',1e5,'Algorithm','sqp',...
                       'DerivativeCheck','on','GradObj','on',...
                       'GradConstr','on','NLPsolver','fmincon');

optimparam.optvar = 3; 
optimparam.objtype = []; 
optimparam.ncolx = 3; 
optimparam.ncolu = 2; 
optimparam.li = ones(10,1)*(0.2/10); 
optimparam.tf = 0.2;
optimparam.ui = [ones(1,10)*10;ones(1,10)*3;ones(1,10)*2;ones(1,10)*10];
optimparam.par = []; 
optimparam.bdu = [0 20;0 6;0 4;0 20]; 
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
