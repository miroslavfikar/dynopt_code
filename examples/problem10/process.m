function sys = process(t,x,flag,u,p)

  if flag == 0 % ODE system 
   ki0 = [1e3; 1e7; 10; 1e-3];
   Ei  = [3000; 6000; 3000; 0];
   sys = [-(ki0(1)*exp(-Ei(1)/u))*x(1)-(ki0(2)*exp(-Ei(2)/u))*x(1);
          (ki0(1)*exp(-Ei(1)/u))*x(1)-((ki0(3)*exp(-Ei(3)/u))+...
          (ki0(4)*exp(-Ei(4)/u)))*x(2);
           ki0(3)*exp(-Ei(3)/u)*x(2)];
  elseif flag == 5  % initial conditions
    sys = [1;0;0];
  else
    sys = [];
  end
end