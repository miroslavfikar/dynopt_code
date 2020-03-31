function sys = processd(t,x,u,p,flag)

% parameters can be set through global variables :
global x10 x20 x30

% do not modify the individual IF,ELSE conditions !!
    if flag == 5
        % initial conditions for ODE system x0 can be scalar or vector:
        sys = [x10;x20;x30];        
    elseif flag == 1 % df/dx
        sys = [0 0 2*x(1);
               1 -1 2*x(2);
               0 0 0];
    elseif flag == 2 % df/du
        sys = [0 1 0.01*u];
    elseif flag == 4 % df/dt
        sys = []; 
    else
        % ODE system :     
        sys = [x(2);
              -x(2)+u;
               x(1)^2+x(2)^2+0.005*u^2];
    end
end