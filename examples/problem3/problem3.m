options = optimset('LargeScale','off','Display','iter');
options = optimset(options,'GradObj','on','GradConstr','on');
options = optimset(options,'MaxFunEvals',1e5);
options = optimset(options,'MaxIter',1e5);
options = optimset(options,'TolFun',1e-7);
options = optimset(options,'TolCon',1e-7);
options = optimset(options,'TolX',1e-7);
options = optimset(options,'Algorithm','active-set'); %2008b

optimparam.optvar = 3; 
optimparam.objtype = []; 
optimparam.ncolx = 6; 
optimparam.ncolu = 2; 
optimparam.li = [ones(7,1)*(1/7)]; 
optimparam.tf = 1;
optimparam.ui = zeros(1,7); 
optimparam.par = []; 
optimparam.bdu = [];
optimparam.bdx = [];
optimparam.bdp =[];
optimparam.objfun = @objfun;
optimparam.confun = @confun;
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam]=dynopt(optimparam)
save optimresults optimout optimparam
[tplot,uplot,xplot] = profiles(optimout,optimparam,50);
[tp,cp,ceqp] = constraints(optimout,optimparam,50);

save optimprofiles tplot uplot xplot tp cp ceqp

%graph
