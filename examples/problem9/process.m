function sys = process(t,x,u,p,flag)

% do not modify the individual IF,ELSE conditions !!
    if flag == 7
        % mass matrix
        sys = [];
    elseif flag == 5
        % initial conditions for ODE system:
        sys = initial_conditions([150;300;0.03]);        
    else
    % ODE system :
    s= [68.1250e-9,   -56.4512e-6,   32.5553e-3,   -4.3529e-9,    3.3216e-6,   -2.7141e-3];
    z= [-0.0769e-6   -0.0035e-3    0.0349e-3    0.9961];
    w= [7.8407e-6   -4.0507e-3    1.0585    1.2318e-9   -9.7660e-6   -1.1677e-3];
    q =  (s(1)*x(2).^2 + s(2)*x(2) + s(3)) .* exp((s(4)*x(2).^2 + s(5)*x(2) + s(6)).*x(1)); 
    %in [m/h] 
    r1 = (z(1)*x(2)+z(2)).*x(1)  +  (z(3)*x(2)+z(4)); 
    r2 = (w(1)*x(2).^2 + w(2)*x(2) + w(3)) .* exp((w(4)*x(2).^2 + w(5)*x(2) + w(6)).*x(1));
    alpha = u(1); vw = alpha * q;
    
    sys = [ x(1)*(q*r1-vw)/x(3);
	    x(2)*(q*r2-vw)/x(3);
	    vw-q];
    end
end