options = optimset('LargeScale','off','Display','iter');
options = optimset(options,'GradObj','on','GradConstr','on');
options = optimset(options,'MaxFunEvals',1e5);
options = optimset(options,'MaxIter',1e5);
options = optimset(options,'TolFun',1e-7);
options = optimset(options,'TolCon',1e-7);
options = optimset(options,'TolX',1e-7);
%options = optimset(options,'Algorithm','sqp'); %2010a
options = optimset(options,'Algorithm','active-set'); %2008b

n=2;
optimparam.optvar = 3; 
optimparam.objtype = []; 
optimparam.ncolx = 3; 
optimparam.ncolu = 1; 
optimparam.li = ones(n,1)*(1/n)*6; 
optimparam.tf = 6;
optimparam.ui = .5*ones(1,n); 

optimparam.par = []; 
optimparam.bdu = [0 1];
optimparam.bdx = [0 1600;0 600; 0.01 0.035];
optimparam.bdp =[];
optimparam.objfun = @objfun;
optimparam.confun = @confun;
%optimparam.confun = [];
optimparam.process = @process;
optimparam.options = options;


[optimout,optimparam]=dynopt(optimparam)
save optimresults optimout optimparam
[tplot,uplot,xplot] = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot

%graphplot
