function Df = objfund(t,x,u,p,xm)

% gradients of the objective function
Df.t = [];    % dJ/dt
Df.x = [2*(x(1)-xm(1));0]; % dJ/dx
Df.u = [];    % dJ/du
Df.p = [];    % dJ/dp