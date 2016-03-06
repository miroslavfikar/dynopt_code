options = optimset('LargeScale','off','Display','iter');
options = optimset(options,'GradObj','on','GradConstr','on');
options = optimset(options,'TolFun',1e-7);
options = optimset(options,'TolCon',1e-7);
options = optimset(options,'TolX',1e-7);
options = optimset(options,'Algorithm','active-set');

objtype.tm = [1;2;3;5]; 
objtype.xm = [0.264 0.594 0.801 0.958;
              NaN NaN NaN NaN]; 

optimparam.optvar = 4; 
optimparam.objtype = objtype; 
optimparam.ncolx = 4; 
optimparam.ncolu = []; 
optimparam.li = ones(6,1);
optimparam.tf = [];
optimparam.ui = [];
optimparam.par = [0;0]; 
optimparam.bdu = []; 
optimparam.bdx = [];
optimparam.bdp = [-1.5 1.5;-1.5 1.5];
optimparam.objfun = @objfun;
optimparam.confun = []; 
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam]=dynopt(optimparam)
save optimresults optimout optimparam
[tplot,uplot,xplot] = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot 

graph