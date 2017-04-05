function [c, ceq] = confun(t,x,u,p,flag)

    if flag == 0                % constraints in t0
        c   = [];
        ceq = [];
    elseif flag == 1            % constraints over interval [t0,tf]
        c   = [];
        ceq = [];
    elseif flag == 2            % constraints in tf
          c = [];
        ceq = [x(3)-0.01];
    end
end