function [Dc,Dceq] = confund(t,x,flag,u,p)
  Dc.t = [];
  Dc.x = [];
  Dc.u = [];
  Dc.p = [];
  Dceq.t = [];
  Dceq.x = [];
  Dceq.u = [];
  Dceq.p = [];
  
  if flag ==2 % constraints in tf
    % ceq = [x(1) - x1f; x(2) - x2f];
    Dceq.x = [1 0;0 1];
  end
end