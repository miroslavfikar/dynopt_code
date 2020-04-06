function [c, ceq] = confun(t,x,flag,u,p)
global x1f x2f x1t

    if flag == 0                % constraints in t0
        c   = [];
        ceq = [];
    elseif flag == 1            % constraints over interval [t0,tf]
        x1 = x(1);
        c   = [x1 - x1t];
        ceq = [];
    elseif flag == 2            % constraints in tf
        x1 = x(1); x2 = x(2);
          c = [];
        ceq = [x1 - x1f; x2 - x2f];
    end
end