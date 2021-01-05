clear all; close all
options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-7,...
                       'TolCon',1e-7,'TolX',1e-7,...
                       'MaxFunEvals',1e5,'MaxIter',4000,'Algorithm','sqp',...
                       'NLPsolver','fmincon');
ni = 4;
optimparam.optvar = 3;
optimparam.objtype = [];
optimparam.ncolx = 3;
optimparam.ncolu = 2;
optimparam.li = ones(ni,1)*20;
optimparam.tf = [];
optimparam.ui = 0*ones(1,ni);
optimparam.par = [];
optimparam.bdu = [0 50];
optimparam.bdx = [0 40; 0 100; 0 25; 0 10];
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
legend('x_1','x_2','x_3','x_4','Orientation','horizontal')
xlabel('time')
ylabel('x_1, x_2, x_3, x_4')
ylim([-1 35])
box on
set(gca, 'FontSize', 12)
%print -depsc 'fermentor_states.eps'
hold off

figure
plot(tplot,uplot,'k')
ylim([-1 51])
xlabel('time')
ylabel('u')
set(gca, 'FontSize', 12)
box on
%print -depsc 'fermentor_control.eps'
