function sys = process(t,x,flag,u,p)

  if flag == 0 % ODE system 
    sys = [u(1); 
	   x(1)^2 + u(1)^2];
  elseif flag == 5  % initial conditions
    sys = [1; 0];
  else
    sys = [];
  end
end