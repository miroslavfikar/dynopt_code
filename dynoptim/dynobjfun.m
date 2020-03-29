function [f,Df] = dynobjfun(t,x,u,p, param, xm)

% objective function
if isempty(param.objtype) % objfun: Meyer
  f = param.origobjfun(t,x,u,p); % J
else % objfun: Sum
  f = param.origobjfun(t,x,u,p, xm); % J
end

% calculating gradients \wrt to {t, x, u p} using adigator
if isempty(param.objtype) % objfun: Meyer
  [JacT,JacX,JacU,JacP] = dgrad_objfun(t,x,u,p, param);
else % objfun: Sum
  [JacT,JacX,JacU,JacP] = dgrad_objfun(t,x,u,p, param, xm);
end

% gradients of the objective function
Df.t = JacT;   % dJ/dt
Df.x = JacX;   % dJ/dx
Df.u = JacU;   % dJ/du
Df.p = JacP;   % dJ/dp

%[f,Df] = objfund(t,x,u,p); % J
