function [Dc,Dceq] = confund(t,x,u,p,flag)

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
    Dc.t = [];
    Dc.x = [];
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