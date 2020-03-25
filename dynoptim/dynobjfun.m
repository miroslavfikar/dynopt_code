function [f,Df] = dynobjfun(t,x,u,p, param)

% objective function
f = param.origobjfun(t,x,u,p); % J

% calculating gradients \wrt to {t, x, u p} using adigator
[JacT,JacX,JacU,JacP] = dgrad_objfun(t,x,u,p, param);

% gradients of the objective function
Df.t = JacT;   % dJ/dt
Df.x = JacX;   % dJ/dx
Df.u = JacU;   % dJ/du
Df.p = JacP;   % dJ/dp

%[f,Df] = objfund(t,x,u,p); % J