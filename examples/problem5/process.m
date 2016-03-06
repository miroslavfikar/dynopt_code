function sys = process(t,x,flag,u,p)

switch flag
    case 0 % f(x,u,p,t)
        sys = [-4000*exp(-u)*(x(1)^2);
                4000*exp(-u)*(x(1)^2)-620000*exp(-2*u)*x(2)];
    case 1 % df/dx
        sys = [-8000*exp(-u)*x(1),8000*exp(-u)*x(1);
                0,-620000*exp(-2*u)];
    case 2 % df/du
        sys = [-4000*exp(-u)*(x(1)^2)*(-1),4000*exp(-u)*(x(1)^2)*(-1)-620000*exp(-2*u)*x(2)*(-2)];
    case 3 % df/dp
        sys = [];
    case 4 % df/dt
        sys = [];
    case 5 % x0
        sys = [1;0];
    case 6 % dx0/dp
        sys = [];
    case 7 % M
        sys = [];
    case 8 % unused flag
        sys = [];
    otherwise
        error(['unhandled flag = ',num2str(flag)]); 
end