function sys = process(t,x,flag,u,p)
  global x10 x20

  if flag == 5 % initial conditions for ODE system
    sys = [x10;x20];
  else % ODE system 
    sys = [u(1);
	   x(1)];
  end
end