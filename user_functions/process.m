function sys = process(t,x,flag,u,p)
% PROCESS -  returns the description of optimised process with respect to
% given flag.


switch flag,
    case 0 % right sides of ODE/DAEs: f(x,u,p,t)
        sys = [];
    case 1 % gradients of f with respect to x: df/dx
        sys = [];
    case 2 % gradients of f with respect to u: df/du
        sys = [];
    case 3 % gradients of f with respect to p: df/dp
        sys = [];
    case 4 % gradients of f with respect to t: df/dt
        sys = [];
    case 5 % initial condition: x0
        sys = [];
    case 6 % gradients of x0 with respect to p: dx0/dp
        sys = [];
    case 7 % mass matrix M
        sys = [];
    case 8 % unused flag, don't use it !!! 
        sys = []; % this flag will be maybe used in next version
    otherwise
        error(['unhandled flag = ',num2str(flag)]); 
end