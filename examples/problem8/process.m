function sys = process(t,x,u,p,flag)

% do not modify the individual IF,ELSE conditions !!
    if flag == 5
        % initial conditions for ODE system:
        sys = [p(1);p(2)];
    else
        % ODE system :
        sys = [x(2);
               1-2*x(2)-x(1)];
    end
end 
