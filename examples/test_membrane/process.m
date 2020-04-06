function sys = process(t,x,flag,u,p)

% parameters can be set through global variables :
  global c10 c20 V0 Vw0 R1 R2 k clim A

  if flag == 5 % initial conditions for ODE system:
    sys = [c10;c20;V0;Vw0];        
  else % ODE system
    c1 = x(1); c2 = x(2); V = x(3); aq = x(4);
    q = k*A*log(clim/c1);
    
    sys = [(c1*q/V)*(R1 - u);
	   (c2*q/V)*(R2 - u);
	   (u - 1)*q;
	   u*q];
  end
end