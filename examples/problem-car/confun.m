function [c, ceq] = confun(t,x,flag,u,p)
global x1f x2f

    if flag == 0                % constraints in t0
        c   = [];
        ceq = [];
    elseif flag == 1            % constraints over interval [t0,tf]
        c   = [];
        ceq = [];
    elseif flag == 2            % constraints in tf
          c = [];
        ceq = [x(1) - x1f; x(2) - x2f];
    end
end