function [f,Df] = objfun(t,x,u,p)

% objective function
f = [x(2)]; % J

% gradients of the objective function
Df.t = [];    % dJ/dt
Df.x = [0;1]; % dJ/dx
Df.u = [];    % dJ/du
Df.p = [];    % dJ/dp