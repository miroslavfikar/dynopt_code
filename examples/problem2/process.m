function sys = process(t,x,u,p,flag)

% parameters can be set through global variables :
global x10 x20 x30 x40

% do not modify the individual IF,ELSE conditions !!
    if flag == 7
        % mass matrix
        sys = [];
    elseif flag == 5
        % initial conditions for ODE system:
        sys = initial_conditions([x10;x20;x30;x40]);        
    else
        % ODE system :
        x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4);
        
        sys = [x2;
               -x3*u + 16*t - 8;
               u;
               x1^2 + x2^2 + 0.0005*(x2 + 16*t - 8 - 0.1*x3*u^2)^2];
    end
end