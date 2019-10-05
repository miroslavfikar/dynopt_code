function sys = processd(t,x,u,p,flag)

% do not modify the individual IF,ELSE conditions !!
    if flag == 5
        % initial conditions for ODE system x0 can be scalar or vector:
        sys = [0;0];
    elseif flag == 1 % df/dx
        sys = [0 1;0 0];
    elseif flag == 2 % df/du
        sys = [1 0];
    elseif flag == 4 % df/dt
        sys = [];
    else
        % ODE system :     
        sys = [u(1);
               x(1)];
    end
end