function sys = process(t,x,u,p,flag)

  global x10 x20

  if flag == 5 % initial conditions
    sys = [x10;x20];        
  else % ODE system
    sys = [u*(10*x(2)-x(1));
	   -u*(10*x(2)-x(1))-(1-u)*x(2)];
  end
end