function [c, ceq] = confun_function(t,x,u,p,flag)
global c1f c2f c10 c20 V0 Vw0

    if flag == 0                % constraints in t0
        c1 = x(1); c2 = x(2); V = x(3); Vw = x(4);
        c   = [];
        ceq = [c1 - c10;c2 - c20;V - V0; Vw - Vw0];
    elseif flag == 1            % constraints over interval [t0,tf]
        c1 = x(1); c2 = x(2); V = x(3); Vw = x(4);
        c   = [c1 - 140; c2 - 35; V - 1; Vw - 1;u-100;-u-0];
        ceq = [];
    elseif flag == 2            % constraints in tf
        c1 = x(1); c2 = x(2);
          c = [];
        ceq = [c1 - c1f; c2 - c2f];
    end
end