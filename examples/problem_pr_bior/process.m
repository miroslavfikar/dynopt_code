function sys = process(t, x, flag, u, p)

if flag == 0            % ODE system
    g(3) = 21.87*(x(4))/((x(4) + .4)*(x(4) + 62.5));
    g(1) = 4.75*(g(3))/(.12 + g(3));
    g(2) = (x(4))/(.1 + x(4))*exp(-5*x(4));
    sys  = [g(1)*(x(2)-x(1))-u/x(5)*x(1); g(2)*x(3)-u/x(5)*x(2); ...
           g(3)*x(3)-u/x(5)*x(3); -7.3*g(3)*x(3)+u/x(5)*(20-x(4)); u];
elseif flag == 5        % initial conditions
    sys = [0; 0; 1; 5; 1];
else
    sys = [];
end
end