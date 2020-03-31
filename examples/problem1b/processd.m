function sys = processd(t,x,u,p,flag)

% parameters can be set through global variables :
global x10 x20

% do not modify the individual IF,ELSE conditions !!
    if flag == 5
        % initial conditions for ODE system x0 can be scalar or vector:
        sys = [x10; x20];
    elseif flag == 1 % df/dx
        sys = [0 2*x(1);0 0];
    elseif flag == 2 % df/du
        sys = [1 2*u];
    else
        % ODE system :     
        sys = [u; 
               x(1)^2 + u^2];
    end
end