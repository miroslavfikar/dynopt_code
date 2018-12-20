options = optimset('LargeScale','off','Display','iter');
options = optimset(options,'MaxFunEvals',1e6);
options = optimset(options,'TolFun',1e-7);
options = optimset(options,'TolCon',1e-7);
options = optimset(options,'TolX',1e-7);
options = optimset(options,'MaxIter',4000);
options = optimset(options,'Algorithm','interior-point'); %2013b
%options = optimset(options,'Algorithm','sqp'); %2010a
%options = optimset(options,'Algorithm','active-set'); %2008b

optimparam.optvar = 3; 
optimparam.objtype = []; 
optimparam.ncolx = 3; 
optimparam.ncolu = 2; 
optimparam.li = ones(3,1)*(1/3); 
optimparam.tf = 1;
optimparam.ui = zeros(1,3); 
optimparam.par = []; 
optimparam.bdu = []; 
optimparam.bdx = []; 
optimparam.bdp =[];
optimparam.objfun = @objfun; 
optimparam.confun = []; 
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam]=dynopt(optimparam)
save optimresults optimout optimparam
[tplot,uplot,xplot] = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot 

%graphplot
