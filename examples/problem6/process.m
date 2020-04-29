function sys = process(t,x,flag,u,p)

  global x10 x20

  if flag == 0 % ODE system 
    sys = [u*(10*x(2)-x(1));
	   -u*(10*x(2)-x(1))-(1-u)*x(2)];
  elseif flag == 5  % initial conditions
    sys = [x10;x20];        
  else
    sys = [];
  end
end