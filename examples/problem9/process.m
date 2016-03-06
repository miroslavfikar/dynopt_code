function sys = process(t,x,flag,u,p)

  
  switch flag,
   case 0 % f(x,u,p,t)
    s= [68.1250e-9,   -56.4512e-6,   32.5553e-3,   -4.3529e-9,    3.3216e-6,   -2.7141e-3];
    z= [-0.0769e-6   -0.0035e-3    0.0349e-3    0.9961];
    w= [7.8407e-6   -4.0507e-3    1.0585    1.2318e-9   -9.7660e-6   -1.1677e-3];
    q =  (s(1)*x(2).^2 + s(2)*x(2) + s(3)) .* exp((s(4)*x(2).^2 + s(5)*x(2) + s(6)).*x(1)); %in [m/h] 
    r1 = (z(1)*x(2)+z(2)).*x(1)  +  (z(3)*x(2)+z(4)); 
    r2 = (w(1)*x(2).^2 + w(2)*x(2) + w(3)) .* exp((w(4)*x(2).^2 + w(5)*x(2) + w(6)).*x(1));
    alpha = u(1); u = alpha * q;
    sys = [ x(1)*(q*r1-u)/x(3);
	    x(2)*(q*r2-u)/x(3);
	    u-q];
   case 1 % df/dx
    s= [68.1250e-9,   -56.4512e-6,   32.5553e-3,   -4.3529e-9,    3.3216e-6,   -2.7141e-3];
    z= [-0.0769e-6   -0.0035e-3    0.0349e-3    0.9961];
    w= [7.8407e-6   -4.0507e-3    1.0585    1.2318e-9   -9.7660e-6   -1.1677e-3];
    q =  (s(1)*x(2).^2 + s(2)*x(2) + s(3)) .* exp((s(4)*x(2).^2 + s(5)*x(2) + s(6)).*x(1)); %in [m/h] 
    r1 = (z(1)*x(2)+z(2)).*x(1)  +  (z(3)*x(2)+z(4)); 
    r2 = (w(1)*x(2).^2 + w(2)*x(2) + w(3)) .* exp((w(4)*x(2).^2 + w(5)*x(2) + w(6)).*x(1));
    alpha = u(1); u = alpha * q;

    dqdx1=(s(1)*x(2)^2+s(2)*x(2)+s(3))*(s(4)*x(2)^2+s(5)*x(2)+s(6))*exp((s(4)*x(2)^2+s(5)*x(2)+s(6))*x(1));
    dqdx2=(2*s(1)*x(2)+s(2))*exp((s(4)*x(2)^2+s(5)*x(2)+s(6))*x(1))+(s(1)*x(2)^2 +s(2)*x(2)+s(3))*(2*s(4)*x(2)+s(5))*x(1)*exp((s(4)*x(2)^2+s(5)*x(2)+s(6))*x(1));
    dqdx3=0;
    
    dr1dx1=z(1)*x(2)+z(2);
    dr1dx2=z(1)*x(1)+z(3);
    dr1dx3=0;

    dr2dx1= (w(1)*x(2)^2+w(2)*x(2)+w(3))*(w(4)*x(2)^2+w(5)*x(2)+w(6))*exp((w(4)*                   x(2)^2+w(5)*x(2)+w(6))*x(1));
    dr2dx2=(2*w(1)*x(2)+w(2))*exp((w(4)*x(2)^2+w(5)*x(2)+w(6))*x(1))+(w(1)*x(2)^                   2+w(2)*x(2)+w(3))*(2*w(4)*x(2)+w(5))*x(1)*exp((w(4)*x(2)^2+w(5)*x(2)+w(6))*x(1));
    dr2dx3=0;
    
    dudx1 = alpha * dqdx1; 
    dudx2 = alpha * dqdx2; 

    df1dx1 = (x(1)*(dqdx1*r1 + dr1dx1*q - dudx1))/x(3) - (u - q*r1)/x(3);
    df1dx2 = (x(1)*(dqdx2*r1 + dr1dx2*q - dudx2))/x(3);
    df1dx3 = (x(1)*(u - q*r1))/x(3)^2;
    df2dx1 = (x(2)*(dqdx1*r2 + dr2dx1*q - dudx1))/x(3);
    df2dx2 = (x(2)*(dqdx2*r2 + dr2dx2*q - dudx2))/x(3) - (u - q*r2)/x(3);
    df2dx3 = (x(2)*(u - q*r2))/x(3)^2;
    df3dx1 = -dqdx1*(alpha-1);
    df3dx2 = -dqdx2*(alpha-1);
    df3dx3 = 0;
    
    sys = [df1dx1 df2dx1 df3dx1;
	   df1dx2 df2dx2 df3dx2;
	   df1dx3 df2dx3 df3dx3];
   case 2 % df/du (u is alpha)
    s= [68.1250e-9,   -56.4512e-6,   32.5553e-3,   -4.3529e-9,    3.3216e-6,   -2.7141e-3];
    z= [-0.0769e-6   -0.0035e-3    0.0349e-3    0.9961];
    w= [7.8407e-6   -4.0507e-3    1.0585    1.2318e-9   -9.7660e-6   -1.1677e-3];
    q =  (s(1)*x(2).^2 + s(2)*x(2) + s(3)) .* exp((s(4)*x(2).^2 + s(5)*x(2) + s(6)).*x(1)); %in [m/h] 

    sys = q*[-x(1)/x(3) -x(2)/x(3) 1];
   case 3 % df/dp
    sys = [];
   case 4 % df/dt
    sys = []; 
   case 5 % x0
    sys = [150;300;0.03];
   case 6 % dx0/dp
    sys = [];
   case 7 % M
    sys = [];
   case 8 % unused flag
    sys = [];
   otherwise
    error(['unhandled flag = ',num2str(flag)]); 
  end