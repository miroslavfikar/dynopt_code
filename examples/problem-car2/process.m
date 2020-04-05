function sys = process(t,x,u,p,flag)
  global x10 x20
  
  if flag == 5 % initial conditions
    sys = [x10;x20];
  else % ODE system :
    sys = [u;
	   x(1)];
  end
end