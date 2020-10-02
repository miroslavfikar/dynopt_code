clear
clc

options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-7,...
                       'TolCon',1e-7,'TolX',1e-7,...
                       'MaxFunEvals',1e5,'MaxIter',300,'Algorithm','sqp',...
                       'NLPsolver','fmincon');
optimparam.optvar = 3;
optimparam.objtype = [];
optimparam.ncolx = 7;
optimparam.ncolu = 2;
optimparam.li = ones(14,1)*(1/3);
optimparam.tf = [];
optimparam.ui = ones(1,14)*6;
optimparam.par = [];
optimparam.bdu = [0 12];
optimparam.bdx = [];
optimparam.bdp = [];
optimparam.objfun  = @objfun;
optimparam.confun  = @confun;
optimparam.process = @process;
optimparam.options = options;
[optimout, optimparam] = dynopt(optimparam);
[tplot,uplot,xplot]    = profiles(optimout,optimparam,50);
% [tp,cp,ceqp] = constraints(optimout,optimparam,50);

%% plot
figure
hold on
lines = {'k','b','r','g'};
for i = 1:4
    plot(tplot,xplot(:,i),lines{i})
end
legend('x_1','x_2','x_3','x_4')
xlabel('time')
ylabel('x_1, x_2, x_3, x_4')
ylim([0 200])
% xlim([0 60])
box on
set(gca, 'FontSize', 12)
% print -depsc 'batch_states_dynopt.eps'
hold off

figure
plot(tplot,uplot,'k')
ylim([0 12])
% xlim([0 60])
xlabel('time')
ylabel('u')
set(gca, 'FontSize', 12)
box on
% print -depsc 'batch_control_dynopt.eps'
J_opt = -optimout.fval