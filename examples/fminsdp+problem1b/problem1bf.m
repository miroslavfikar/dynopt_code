function problem1bf

clear
close all
warning on

options = sdpoptionset('LargeScale','off',...
    'GradObj','on',...
    'GradConstr','on',...
    'Display','iter',...
    'MaxFunEvals',1e4,...
    'TolFun',1e-7,...
    'TolX',1e-7,...
    'TolCon',1e-6,...
    'MaxIter',2e3,...
    'Algorithm','interior-point',...
    'NLPsolver','ipopt');


optimparam.optvar = 3; 
optimparam.objtype = []; 
optimparam.ncolx = 6;
optimparam.ncolu = 2; 
optimparam.li = ones(4,1)*(1/4);
optimparam.tf = 1;
optimparam.ui = zeros(1,4);
optimparam.par = []; 
optimparam.bdu = []; 
optimparam.bdx = [0 1;0 1]; 
optimparam.bdp =[];
optimparam.objfun = @objfun; 
optimparam.confun = @confun; 
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam] = dynoptNEW(optimparam);

end

function sys = process(t,x,flag,u,p)

switch flag,
    case 0 % f(x,u,p,t)
        sys = [u;x(1)^2+u^2];
    case 1 % df/dx
        sys = [0 2*x(1);0 0];
    case 2 % df/du
        sys = [1 2*u];
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

function [f,Df] = objfun(t,x,u,p)

% objective function
f = [x(2)]; % J

% gradients of the objective function
Df.t = [];    % dJ/dt
Df.x = [0;1]; % dJ/dx
Df.u = [];    % dJ/du
Df.p = [];    % dJ/dp
end

function [c,ceq,Dc,Dceq] = confun(t,x,flag,u,p)

switch flag
    case 0 % constraints in t0
        c = [];
        ceq = [];
        
        % gradient calculus
        if nargout == 4
            Dc.t = [];
            Dc.x = [];
            Dc.u = [];
            Dc.p = [];
            Dceq.t = [];
            Dceq.x = [];
            Dceq.u = [];
            Dceq.p = [];
        end
    case 1 % constraints over interval [t0,tf]
        c = [];
        ceq = [];
        
        % gradient calculus
        if nargout == 4
            Dc.t = [];
            Dc.x = [];
            Dc.u = [];
            Dc.p = [];
            Dceq.t = [];
            Dceq.x = [];
            Dceq.u = [];
            Dceq.p = [];
        end
    case 2 % constraints in tf
        c = [];
        ceq = [x(1)-1];
        
        % gradient calculus   
        if nargout == 4
            Dc.t = [];
            Dc.x = [];
            Dc.u = [];
            Dc.p = [];
            Dceq.t = [];
            Dceq.x = [1;0];
            Dceq.u = [];
            Dceq.p = [];
        end
end
end
