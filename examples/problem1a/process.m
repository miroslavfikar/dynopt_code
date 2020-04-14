function sys = process(t,x,flag,u,p)

  if flag == 5 % initial conditions
    sys = [1; 0];
  else    % ODE system 
    sys = [u(1); 
	   x(1)^2 + u(1)^2];
  end
end