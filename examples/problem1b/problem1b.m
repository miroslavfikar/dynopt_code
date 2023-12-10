clear all; close all; clc;
options = sdpoptionset('LargeScale','off','Display','iter','TolFun',1e-7,...
                       'TolCon',1e-6,'TolX',1e-7,...
                       'MaxFunEvals',1e6,'MaxIter',40000,...
                       'Algorithm','interior-point','NLPsolver','fmincon',...
                       'DerivativeCheck','on');

optimparam.optvar = 3;
optimparam.objtype = [];
optimparam.ncolx = 6; 
optimparam.ncolu = 2; 
optimparam.li = ones(2,1)*(1/2);
optimparam.tf = 1;
optimparam.ui = zeros(1,2);
optimparam.par = []; 
optimparam.bdu = []; 
optimparam.bdx = [0 1;0 1]; 
optimparam.bdp = [];
optimparam.objfun  = @objfun;
optimparam.confun  = @confun;
optimparam.process = @process;
optimparam.options = options;
optimparam.adoptions = adoptionset('jacuser',true);

[optimout,optimparam] = dynopt(optimparam);
save optimresults optimout optimparam
[tplot,uplot,xplot]   = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot 

figure
subplot(2,1,1)
plot(tplot, xplot)
plot(tplot,uplot,'k')
title('')
xlabel('time')
ylabel('u')
axis([0 1 -0.6 0.6])
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])


subplot(2,1,2)
plot(tplot,xplot(:,1),'b:',tplot,xplot(:,2),'k-')
title('')
xlabel('time')
ylabel('x_1, x_2')
legend('x_1','x_2')
axis([0 1 0 1])
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

