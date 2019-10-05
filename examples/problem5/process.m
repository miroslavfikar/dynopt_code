function sys = process(t,x,u,p,flag)

% parameters can be set through global variables :
global x10 x20

% do not modify the individual IF,ELSE conditions !!
    if flag == 5
        % initial conditions for ODE system:
        sys = initial_conditions([x10;x20]);        
    else
        % ODE system :
  
        sys = [-4000*exp(-u)*(x(1)^2);
                4000*exp(-u)*(x(1)^2)-620000*exp(-2*u)*x(2)];
    end
end