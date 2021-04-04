function Df = objfund(t,x,u,p)
% gradients of the objective function
  Df.t = [];    % dJ/dt
  Df.x = [0;0;-x(4); -x(3)]; % dJ/dx
  Df.u = [];    % dJ/du
  Df.p = [];    % dJ/dp
end

