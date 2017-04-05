function sys = process(t,x,u,p,flag)

% parameters can be set through global variables :
global x10 x20

% do not modify the individual IF,ELSE conditions !!
    if flag == 7
        % mass matrix
        sys = [];
    elseif flag == 5
        % initial conditions for ODE system x0 can be scalar or vector:
        sys = initial_conditions([x10; x20]);
    else
        % ODE system :     
        x1 = x(1); x2 = x(2);
        sys = [u; 
               x1^2 + u^2];
    end
end