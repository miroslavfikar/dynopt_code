function sys = processdalt(t,x,flag,u,p)

  if flag == 5 % initial conditions
    sys = [0;-1;-sqrt(5);0];
  elseif flag == 1 % df/dx
    sys = [0 0 0 2*x(1);
	   1 0 0 (2*x(2)+2*0.0005*(x(2)+16*t-8-0.1*x(3)*u(1)^2));
	   0 -u(1) 0 2*0.0005*(x(2)+16*t-8-0.1*x(3)*u(1)^2)*(-0.1*u(1)^2);
	   0 0 0 0];
  elseif flag == 2 % df/du
%    sys = [0 -x(3) 1 (2*0.0005*(x(2)+16*t-8-0.1*x(3)*u(1)^2)*(-2*0.1*x(3)*u(1)))];
    sys = [0 -x(3) 1 0.0005*(2*(x(2)+16*t-8-0.1*x(3)*u(1)^2)*(-0.1*x(3)*2*u(1)))];
  elseif flag == 4 % df/dt
    sys = [0 16 0 2*0.0005*(x(2)+16*t-8-0.1*x(3)*u(1)^2)*16];
  else
    sys = [];
  end
end