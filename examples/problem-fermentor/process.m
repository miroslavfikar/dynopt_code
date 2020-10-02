function sys = process(t,x,flag,u,p)

  if flag == 0 % ODE system 
    h1 = 0.11*(x(3)/(0.006*x(1)+x(3)));
    h2 = 0.0055*(x(3)/(0.0001+x(3)*(1+10*x(3))));
    sys = [h1*x(1)-u(1)*x(1)/(500*x(4));
           h2*x(1)-0.01*x(2)-u(1)*x(2)/(500*x(4));
          -h1*x(1)/0.47-h2*x(1)/1.2-0.029*x(1)*x(3)/(0.0001+x(3))+u(1)/x(4)*(1-x(3)/500);
           u(1)/500];
  elseif flag == 5  % initial conditions
    sys = [1.5;0;0;7];
  else
    sys = [];
  end
end