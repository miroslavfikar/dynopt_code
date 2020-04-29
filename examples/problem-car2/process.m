function sys = process(t,x,flag,u,p)
  global x10 x20
  
  if flag == 0 % ODE system 
    sys = [u;
	   x(1)];
  elseif flag == 5  % initial conditions
    sys = [x10;x20];
  else
    sys = [];
  end
end