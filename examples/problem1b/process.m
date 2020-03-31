function sys = process(t,x,u,p,flag)

% parameters can be set through global variables :
global x10 x20

% do not modify the individual IF,ELSE conditions !!
    if flag == 5
        % initial conditions for ODE system x0 can be scalar or vector:
        sys = [1;0];
    else
        % ODE system :     
        sys = [u;x(1)^2+u^2];
    end
end