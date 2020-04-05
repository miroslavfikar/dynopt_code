function [Dc,Dceq] = confund(t,x,u,p,flag)

  Dc.t = [];
  Dc.x = [];
  Dc.u = [];
  Dc.p = [];
  Dceq.t = [];
  Dceq.x = [];
  Dceq.u = [];
  Dceq.p = [];
if flag ==2 % constraints in tf
  Dceq.x = [1;0];
end