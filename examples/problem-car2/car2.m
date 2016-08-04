options = optimset('LargeScale','off','Display','iter');
options = optimset(options,'GradObj','on','GradConstr','on');
options = optimset(options,'MaxFunEvals',1e4);
options = optimset(options,'MaxIter',1e3);
options = optimset(options,'TolFun',1e-7);
options = optimset(options,'TolCon',1e-7);
options = optimset(options,'TolX',1e-7);
options = optimset(options,'Algorithm','sqp'); %2010a
%options = optimset(options,'Algorithm','active-set'); %2008b

%options.NLPsolver='ipopt';

n=3;
optimparam.optvar = 3; 
optimparam.objtype = []; 
optimparam.ncolx = 3;
optimparam.ncolu = 1; 
optimparam.li = 100*ones(n,1)*(1/n);
optimparam.tf = [];
optimparam.ui = zeros(1,n);
optimparam.par = []; 
optimparam.bdu = [-2 1]; 
optimparam.bdx = [0 300;0 400]; 
optimparam.bdp =[];
optimparam.objfun = @objfun; 
optimparam.confun = @confun; 
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam]=dynopt(optimparam)
save optimresults optimout optimparam
[tplot,uplot,xplot] = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot 

%graph