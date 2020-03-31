function sys = process(t,x,u,p,flag)

% parameters can be set through global variables :
global p_vab x0

% do not modify the individual IF,ELSE conditions !!
    if flag == 7
        % mass matrix
        sys = [];
    elseif flag == 5
        % initial conditions for ODE system x0 can be scalar or vector:
        sys = x0;
    else
        % ODE system :     
        x1 = x(1);
        sys = [-x1^2+p_vab];
    end
end