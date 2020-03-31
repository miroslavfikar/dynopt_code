function sys = process(t,x,u,p,flag)

% do not modify the individual IF,ELSE conditions !!
    if flag == 5
        % initial conditions for ODE system:
        sys = [1;0;5.0736;0.9975];        
%    elseif flag == 7
%        % mass matrix
%        sys = zeros(4,4); sys(1,1)=1; sys(2,2) = 1;
    else
        % ODE system :
  
        sys = [-x(3)*(x(1)^2);
                x(3)*(x(1)^2)-x(4)*x(2);
                x(3)-4000*exp(-u);
                x(4)-620000*exp(-2*u)];
    end
end