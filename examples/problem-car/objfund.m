function Df = objfund(t,x,u,p)

% gradients of the objective function
Df.t = 1;    % dJ/dt
Df.x = []; % dJ/dx
Df.u = [];    % dJ/du
Df.p = [];    % dJ/dp