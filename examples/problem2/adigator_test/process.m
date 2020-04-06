function sys = process(t,x,flag,u,p)

% do not modify the individual IF,ELSE conditions !!
    if flag == 7
        % mass matrix
        sys = [];
    elseif flag == 5
        % initial conditions for ODE system:
	x10 = 0;
	x20 = -1;
	x30 = -sqrt(5);
	x40 = 0;
        sys = [x10;x20;x30;x40];        
    else
        % ODE system :
        sys = [x(2);
               -x(3)*u(1)+16*t-8;
               u;
               x(1)^2+x(2)^2+0.0005*(x(2)+16*t-8-0.1*x(3)*u(1)^2)^2];
    end
end