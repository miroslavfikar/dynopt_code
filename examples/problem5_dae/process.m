function sys = process(t,x,flag,u,p)

  if flag == 0 % differential equations
      sys = [-x(3)*(x(1)^2);
	     x(3)*(x(1)^2)-x(4)*x(2);
	     x(3)-4000*exp(-u);
	     x(4)-620000*exp(-2*u)];
  elseif flag == 5  % initial conditions
    sys = [1;0;5.0736;0.9975];        
  else
    sys = [];
  end
end