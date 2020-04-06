function sys = process(t,x,flag,u,p)

  if flag == 5  % initial conditions for ODE system x0
    sys = [1;0];
  else % ODE system
    sys = [u;x(1)^2+u^2];
  end
end