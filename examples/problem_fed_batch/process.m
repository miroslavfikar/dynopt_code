function sys = process(t,x,flag,u,p)

  if flag == 0 % ODE system 
    g(1) = (0.408/(1+x(3)/16)) * (x(2)/(0.22+x(2)));
    g(2) = (1/(1+x(3)/71.5)) * (x(2)/(0.44+x(2)));
    sys = [g(1)*x(1)-u(1)*(x(1)/x(4));
           -10*g(1)*x(1)+u(1)*(150-x(2))/x(4);
           g(2)*x(1) - u(1)*(x(3)/x(4));
           u(1)];
  elseif flag == 5  % initial conditions
    sys = [1;150;0;10];
  else
    sys = [];
  end
end