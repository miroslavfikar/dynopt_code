function [c, ceq] = confun(t,x,flag,u,p)

    if flag == 0                % constraints in t0
        c   = [];
        ceq = [];
    elseif flag == 1            % constraints over interval [t0,tf]
        x1 = x(1); x2 = x(2);
        c   = [x2 - 8*(t-0.5)^2 + 0.5];
        ceq = [];
    elseif flag == 2            % constraints in tf
          c = [];
        ceq = [];
    end
end