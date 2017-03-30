function [f,Df] = objfun(t,x,u,p)

% objective function
f = objfun_function(t,x,u,p); % J

% calculating gradients \wrt to {t, x, u p} using adigator
[JacT,JacX,JacU,JacP] = dgrad_objfun(t,x,u,p);

% gradients of the objective function
Df.t = JacT;   % dJ/dt
Df.x = JacX;   % dJ/dx
Df.u = JacU;   % dJ/du
Df.p = JacP;   % dJ/dp