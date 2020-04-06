function sys = process(t,x,flag,u,p)

% parameters can be set through global variables :
global x10 x20 x30

% do not modify the individual IF,ELSE conditions !!
    if flag == 5
        % initial conditions for ODE system:
        sys = [x10;x20;x30];  
    else
        % ODE system :
        x1 = x(1); x2 = x(2); x3 = x(3);
       
        sys = [x2;
               -x2+u;
               x1^2 + x2^2 + 0.005*u^2];
    end
end