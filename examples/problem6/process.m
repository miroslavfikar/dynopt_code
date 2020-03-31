function sys = process(t,x,u,p,flag)

% parameters can be set through global variables :
global x10 x20

% do not modify the individual IF,ELSE conditions !!
    if flag == 5
        % initial conditions for ODE system:
        sys = [x10;x20];        
    else
        % ODE system :
  
        sys = [u*(10*x(2)-x(1));
               -u*(10*x(2)-x(1))-(1-u)*x(2)];
    end
end