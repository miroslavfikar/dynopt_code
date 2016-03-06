function [f,Df] = objfun(t,x,u,p,xm)
% OBJFUN - returns user given objective function and its derivatives with
% respect to time t, states x, controls u, and parameters p.
%
% If a Mayer form of this function is used, just t, x, u, and p are the
% input arguments to objfun.


f = [];
Df.t = [];
Df.x = [];
Df.u = [];
Df.p = [];
