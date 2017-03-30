function [c, ceq] = confun_function(t,x,u,p,flag)

    if flag == 0                % constraints in t0
        c   = [];
        ceq = [];
    elseif flag == 1            % constraints over interval [t0,tf]
        c   = [];
        ceq = [];
    elseif flag == 2            % constraints in tf
        x1 = x(1); x2 = x(2);
          c = [];
        ceq = [x1 - 1;
               x2 - 0.85];
    end
end