function sys = process(t,x,flag,u,p)

% parameters can be set through global variables :
  global x10 x20

  if flag == 0 % ODE system 
    sys = [-4000*exp(-u)*(x(1)^2);
	   4000*exp(-u)*(x(1)^2)-620000*exp(-2*u)*x(2)];
  elseif flag == 5  % initial conditions
    sys = [x10;x20];        
  else
    sys = [];
  end
end