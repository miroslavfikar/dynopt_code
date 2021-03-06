function sys = processd(t,x,flag,u,p)

  sys = [];
  if flag == 1 % df/dx
    g1 = (0.408/(1+x(3)/16))*(x(2)/(0.22+x(2)));
    g2 = (1/(1+x(3)/71.5))*(x(2)/(0.44+x(2)));
    dg1dx2 = 51/(125*(x(3)/16+1)*(x(2)+11/50))-(51*x(2))/(125*(x(3)/16+1)*(x(2)+11/50)^2);
    dg1dx3 = -(51*x(2))/(2000*(x(3)/16+1)^2*(x(2)+11/50));
    dg2dx2 = 1/(((2*x(3))/143+1)*(x(2)+11/25))-x(2)/(((2*x(3))/143+1)*(x(2)+11/25)^2);
    dg2dx3 = -(2*x(2))/(143*((2*x(3))/143+1)^2*(x(2)+11/25));

    sys = [g1-u/x(4),-10*g1,g2,0;x(1)*dg1dx2,-10*x(1)*dg1dx2-u/x(4),x(1)*dg2dx2,0;x(1)*dg1dx3,-10*x(1)*dg1dx3,x(1)*dg2dx3-u/x(4),0;(u*x(1))/x(4)^2,(u*(x(2)-150))/x(4)^2,(u*x(3))/x(4)^2,0];
  elseif flag == 2 % df/du
      sys = [-x(1)/x(4),-(x(2)-150)/x(4),-x(3)/x(4),1];
  end
end

    