function sys = process(t,x,flag,u,p)

% parameters can be set through global variables :
global p_vab x0

    if flag == 5
        % initial conditions for ODE system x0 can be scalar or vector:
        sys = x0;
    else
        % ODE system :     
        x1 = x(1);
        sys = [-x1^2+p_vab];
    end
end