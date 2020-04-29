function [Dc,Dceq] = confund(t,x,flag,u,p)

  switch flag
   case 0 % constraints in t0
    Dc.t = [];
    Dc.x = [];
    Dc.u = [];
    Dc.p = [];
    Dceq.t = [];
    Dceq.x = [];
    Dceq.u = [];
    Dceq.p = [];
   case 1 % constraints over interval [t0,tf]
    % x1 = x(1); x2 = x(2);
    % c   = [x2 - 8*(t-0.5)^2 + 0.5];
    % ceq = [];
    Dc.t = [-16*t+8];
    Dc.x = [0;1;0];
    Dc.u = [];
    Dc.p = [];
    Dceq.t = [];
    Dceq.x = [];
    Dceq.u = [];
    Dceq.p = [];
   case 2 % constraints in tf
    Dc.t = [];
    Dc.x = [];
    Dc.u = [];
    Dc.p = [];
    Dceq.t = [];
    Dceq.x = [];
    Dceq.u = [];
    Dceq.p = [];
  end