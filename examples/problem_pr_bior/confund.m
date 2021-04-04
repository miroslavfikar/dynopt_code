function [Dc,Dceq] = confund(t,x,flag,u,p)

  switch flag
   case 0 % constraints in t0
    Dc.t = [];
    Dc.x = [1;-1;0;0;0];
    Dc.u = [];
    Dc.p = [];
    Dceq.t = [];
    Dceq.x = [];
    Dceq.u = [];
    Dceq.p = [];
   case 1 % constraints over interval [t0,tf]
    Dc.t = [];
    Dc.x = [1;-1;0;0;0];
    Dc.u = [];
    Dc.p = [];
    Dceq.t = [];
    Dceq.x = [];
    Dceq.u = [];
    Dceq.p = [];
   case 2 % constraints in tf
    Dc.t = [];
    Dc.x = [1;-1;0;0;0];
    Dc.u = [];
    Dc.p = [];
    Dceq.t = [];
    Dceq.x = [];
    Dceq.u = [];
    Dceq.p = [];
  end
end

