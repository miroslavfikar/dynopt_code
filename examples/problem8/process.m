function sys = process(t,x,flag,u,p)

  if flag == 0 % ODE system 
    sys = [x(2);
	   1-2*x(2)-x(1)];
  elseif flag == 5  % initial conditions
    sys = [p(1);p(2)];
  else
    sys = [];
  end
end 
