clear all; close all; clc;
options = optimset('LargeScale','off','Display','iter');
options = optimset(options,'MaxFunEvals',1e5);
options = optimset(options,'MaxIter',1e5);
options = optimset(options,'TolFun',1e-5);
options = optimset(options,'TolCon',1e-5);
options = optimset(options,'TolX',1e-5);
options = optimset(options,'Algorithm','sqp'); %2010a
%options = optimset(options,'Algorithm','active-set'); %2008b

%options.NLPsolver='ipopt';

optimparam.optvar = 3; 
optimparam.objtype = []; 
optimparam.ncolx = 3; 
optimparam.ncolu = 2; 
optimparam.li = ones(10,1)*(0.2/10); 
optimparam.tf = 0.2;
optimparam.ui = [ones(1,10)*10;ones(1,10)*3;ones(1,10)*2;ones(1,10)*10];
optimparam.par = []; 
optimparam.bdu = [0 20;0 6;0 4;0 20]; optimparam.bdx = []; optimparam.bdp =[];
optimparam.objfun = @objfun; 
optimparam.confun = @confun; 
optimparam.confun = []; 
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam]=dynopt(optimparam)
save optimresults optimout optimparam
[tplot,uplot,xplot] = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot 

figure
subplot(1,2,1)
plot(tplot, xplot(:, 1:2))
xlabel('t')
ylabel('x_1, x_2')

subplot(1,2,2)
plot(tplot, uplot)
xlabel('t')
ylabel('u')
