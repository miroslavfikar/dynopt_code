function Df = objfund(t,x,u,p)
% gradients of the objective function
  Df.t = [];    % dJ/dt
  Df.x = [-x(5);0; 0;0;-x(1)]; % dJ/dx
  Df.u = [];    % dJ/du
  Df.p = [];    % dJ/dp
end

