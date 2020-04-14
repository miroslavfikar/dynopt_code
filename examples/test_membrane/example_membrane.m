clear; close all; clc;
%% Global parameters : 
global k A clim c10 Vw0 c20 c1f c2f V0 R1 R2

%% Parameters : 
k    = 4.79e-6*3600;
A    = 1;
clim = 319;
R1   = 1;
R2   = 0;

%% Initial and final condtions : 
c10 = 10;      c1f = 100;               % [mol/m3]
c20 = 31.5;    c2f = 10;                % [mol/m3]
V0  = 0.1;                              % [m3]
Vw0 = 0;

%% Optimization : 

if (c1f > clim/exp(1))
  optimparam.ui = [0 1 0];
else 
  optimparam.ui = [0 1 100];
end

options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-4,...
                       'TolCon',1e-4,'TolX',1e-4,...
                       'MaxFunEvals',1e5,'Algorithm','sqp',...
                       'NLPsolver','fmincon');
%                       'DerivativeCheck','on',...

optimparam.optvar = 3;
optimparam.objtype = [];
optimparam.ncolx = 5; 
optimparam.ncolu = 1; 
optimparam.li = [2.1235;0.4879;1e-3];
optimparam.tf = [];
optimparam.par = []; 
optimparam.bdu = [0 100]; 
optimparam.bdx = [0 140;0 35;0 1;0 1]; 
optimparam.bdp = [];
optimparam.objfun  = @objfun;
optimparam.confun  = @confun;
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam] = dynopt(optimparam);
[tplot,uplot,xplot]   = profiles(optimout,optimparam,50);

figure
subplot(2,2,1)
plot(xplot(:,1),xplot(:,2),c10,c20,'go',c1f,c2f,'rx')
xlabel('c1')
ylabel('c2')
axis([0 130 5 35])

subplot(2,2,2)
plot(tplot,uplot,2.611,1.1,'b^','MarkerEdgeColor','b','MarkerFaceColor','b')
xlabel('t')
ylabel('alpha')
axis([0 3 -0.1 1.11])

subplot(2,2,3)
plot(tplot,xplot(:,4))
xlabel('t')
ylabel('Vw')
axis([0 3 -0.001 11e-3])

subplot(2,2,4)
plot(tplot,xplot(:,1),tplot,xplot(:,2))
xlabel('t')
ylabel('c1c2')
legend('c_1','c_2','Location','NorthWest') 
