function sys = process(t,x,flag,u,p)

  global x10 x20 x30 x40

  if flag == 0 % ODE system 
    sys = [x(2);
	   -x(3)*u + 16*t - 8;
	   u;
	   x(1)^2 + x(2)^2 + 0.0005*(x(2) + 16*t - 8 - 0.1*x(3)*u^2)^2];
  elseif flag == 5  % initial conditions
    sys = [x10;x20;x30;x40];   
  else
    sys = [];
  end
end