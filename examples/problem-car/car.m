clear all; close all; clc;
global x10 x20 x1f x2f
% initial conditions :
x10 = 0; x20 = 0;
% final conditions :
x1f = 0; x2f = 300;

options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-7,...
                       'TolCon',1e-7,'TolX',1e-7,...
                       'MaxFunEvals',1e4,'MaxIter',1e3,'Algorithm','sqp',...
                       'NLPsolver','fmincon');

optimparam.optvar = 3;
optimparam.objtype = [];
optimparam.ncolx = 3;
optimparam.ncolu = 1;
optimparam.li = 100*ones(2,1)*(1/2);
optimparam.tf = [];
optimparam.ui = zeros(1,2);
optimparam.par = [];
optimparam.bdu = [-2 1];
optimparam.bdx = [0 300;0 400];
optimparam.bdp =[];
optimparam.objfun  = @objfun;
optimparam.confun  = @confun;
optimparam.process = @process;
optimparam.options = options;
%optimparam.adoptions = adoptionset('jacuser', true);

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

