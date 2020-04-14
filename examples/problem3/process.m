function sys = process(t,x,flag,u,p)

  if flag == 5 % initial conditions
    sys = [0;-1;0];
  else % ODE system
    sys = [x(2);
	   -x(2)+u;
	   x(1)^2 + x(2)^2 + 0.005*u^2];
  end
end