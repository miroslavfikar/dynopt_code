function sys = process(t,x,flag,u,p)

switch flag
    case 0 % f(x,u,p,t)
        sys = [-x(3)*(x(1)^2);
                x(3)*(x(1)^2)-x(4)*x(2);
                x(3)-4000*exp(-u);
                x(4)-620000*exp(-2*u)];
    case 1 % df/dx
        sys = [-2*x(3)*x(1),2*x(3)*x(1),0,0;
                0,-x(4),0,0;
                -(x(1)^2),x(1)^2,1,0;
                0,-x(2),0,1];
    case 2 % df/du
        sys = [0,0,4000*exp(-u),2*620000*exp(-2*u)];
    case 3 % df/dp
        sys = [];
    case 4 % df/dt
        sys = [];    
    case 5 % x0
        sys = [1;0;5.0736;0.9975];
    case 6 % dx0/dp
        sys = [];
    case 7 % M
        sys = [1,0,0,0;
               0,1,0,0;
               0,0,0,0;
               0,0,0,0];
    case 8 % unused flag
        sys = [];
    otherwise
        error(['unhandled flag = ',num2str(flag)]); 
end