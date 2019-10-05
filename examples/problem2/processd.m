function sys = processd(t,x,u,p,flag)

% do not modify the individual IF,ELSE conditions !!
    if flag == 5
        % initial conditions for ODE system x0 can be scalar or vector:
        sys = [0;-1;-sqrt(5);0];
    elseif flag == 1 % df/dx
        sys = [0 0 0 2*x(1);
               1 0 0 (2*x(2)+2*0.0005*(x(2)+16*t-8-0.1*x(3)*u(1)^2));
               0 -u(1) 0 2*0.0005*(x(2)+16*t-8-0.1*x(3)*u(1)^2)*(-0.1*u(1)^2);
               0 0 0 0];
    elseif flag == 2 % df/du
        sys = [0 -x(3) 1 (2*0.0005*(x(2)+16*t-8-0.1*x(3)*u(1)^2)*(-2*0.1*x(3)*u(1)))];
    elseif flag == 4 % df/dt
        sys = [0 16 0 2*0.0005*(x(2)+16*t-8-0.1*x(3)*u(1)^2)*16];
    else
        % ODE system :     
        sys = [x(2);
               -x(3)*u(1)+16*t-8;
               u(1);
               x(1)^2+x(2)^2+0.0005*(x(2)+16*t-8-0.1*x(3)*u(1)^2)^2];
    end
end