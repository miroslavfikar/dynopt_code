function sys = process(t,x,u,p,flag)

  if flag == 5 % initial conditions
    sys = [p(1);p(2)];
  else % ODE system
    sys = [x(2);
	   1-2*x(2)-x(1)];
  end
end 
