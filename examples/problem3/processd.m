function sys = processd(t,x,flag,u,p)

  global x10 x20 x30

  if flag == 5 % initial conditions
    sys = [x10;x20;x30];        
  elseif flag == 1 % df/dx
    sys = [0 0 2*x(1);
	   1 -1 2*x(2);
	   0 0 0];
  elseif flag == 2 % df/du
    sys = [0 1 0.01*u];
  else
    sys = []; 
  end
end