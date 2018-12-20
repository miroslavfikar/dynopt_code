options = optimset('LargeScale','off','Display','iter');
options = optimset(options,'GradObj','on','GradConstr','on');
options = optimset(options,'MaxFunEvals',1e4);
options = optimset(options,'MaxIter',1e4);
options = optimset(options,'TolFun',1e-7);
options = optimset(options,'TolCon',1e-6);
options = optimset(options,'TolX',1e-7);
%options = optimset(options,'Algorithm','interior-point'); %2013b
%options = optimset(options,'Algorithm','sqp'); %2010a
%options = optimset(options,'Algorithm','active-set'); %2008b

%options.NLPsolver='ipopt';

optimparam.optvar = 3; 
optimparam.objtype = []; 
optimparam.ncolx = 3;
optimparam.ncolu = 2; 
optimparam.li = ones(2,1)*(1/2);
optimparam.tf = 1;
optimparam.ui = zeros(1,2);
optimparam.par = []; 
optimparam.bdu = []; 
optimparam.bdx = [0 1;0 1]; 
optimparam.bdp =[];
optimparam.objfun = @objfun; 
optimparam.confun = @confun; 
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam]=dynopt(optimparam)
save optimresults optimout optimparam
[tplot,uplot,xplot] = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot 

%graphplot