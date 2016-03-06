function [f,Df] = objfun(t,x,u,p)

% objective function
f = [t]; % J

% gradients of the objective function
Df.t = [1];    % dJ/dt
Df.x = []; % dJ/dx
Df.u = [];    % dJ/du
Df.p = [];    % dJ/dp