function problem1af

clear
close all
warning on

options = sdpoptionset('LargeScale','off',...
    'Display','iter',...
    'MaxFunEvals',1e6,...
    'TolFun',1e-7,...
    'TolX',1e-7,...
    'TolCon',1e-7,...
    'MaxIter',4000,...
    'NLPsolver','ipopt');


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

[optimout,optimparam] = dynoptNEW(optimparam);

end

function sys = process(t,x,flag,u,p)

switch flag,
    case 0 % f(x,u,p,t) 
        sys = [u;x(1)^2+u^2];
    case 1 % df/dx
        sys = [];
    case 2 % df/du
        sys = [];
    case 3 % df/dp
        sys = [];
    case 4 % df/dt
        sys = [];
    case 5 % x0
        sys = [1;0];
    case 6 % dx0/dp
        sys = [];
    case 7 % M
        sys = [];
    case 8 % unused flag
        sys = [];
    otherwise
        error(['unhandled flag = ',num2str(flag)]); 
end
end

function f = objfun(t,x,u,p)

f = [x(2)];

end

