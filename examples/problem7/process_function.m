function sys = process_function(t,x,u,p,flag)

% parameters can be set through global variables :
global x10 x20 x30 x40 x50 x60 x70 x80

% do not modify the individual IF,ELSE conditions !!
    if flag == 7
        % mass matrix
        sys = [];
    elseif flag == 5
        % initial conditions for ODE system:
        sys = initial_conditions([x10;x20;x30;x40;x50;x60;x70;x80]);        
    else
        % ODE system :
        x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4);
        x5 = x(5); x6 = x(6); x7 = x(7); x8 = x(8);
        u1 = u(1); u2 = u(2); u3 = u(3); u4 = u(4); 
        
        q = u1 + u2 + u3;      
        sys = [u4-q*x1-17.6*x1*x2-23.0*x1*x6*u3;
               u1-q*x2-17.6*x1*x2-146.0*x2*x3;
               u(2)-q*x3-73.0*x2*x3;
               -q*x4+35.20*x1*x2-51.30*x4*x5;
               -q*x5+219.0*x2*x3-51.30*x4*x5;
               -q*x6+102.60*x4*x5-23.0*x1*x6*u3;
               -q*x7+46.0*x1*x6*u3;
               5.80*((q*x1)-u4)-3.70*u1-4.10*u2+q*(23.0*x4+...
               11.0*x5+28.0*x6+35.0*x7)-5.0*u3^2-0.099];
    end
end