function [f,Dft,Dfx,Dfu] = objfun(t,x,u)

f=[-x(8)];
Dft=[];
Dfx=[0;0;0;0;0;0;0;-1];
Dfu=[];
