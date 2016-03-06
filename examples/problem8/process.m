function sys = process(t,x,flag,u,p)

switch flag
    case 0 % f(x,u,p,t)
        sys = [x(2);
               1-2*x(2)-x(1)];
    case 1 % df/dx
        sys = [0 -1;
               1 -2];
    case 2 % df/du
        sys = [];
    case 3 % df/dp
        sys = [0 0;
               0 0];
    case 4 % df/dt
        sys = [];
    case 5 % x0
        sys = [p(1);p(2)];
    case 6 % dx0dp
        sys = [1 0;
               0 1];
    case 7 % M
        sys = [];
    case 8 % unused flag
        sys = [];
    otherwise
        error(['unhandled flag = ',num2str(flag)]); 
end