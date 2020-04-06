function [c, ceq] = confun(t,x,flag,u,p)

  if flag == 0                % constraints in t0
    c   = [];
    ceq = [];
  elseif flag == 1            % constraints over interval [t0,tf]
    c   = [];
    ceq = [];
  elseif flag == 2            % constraints in tf
    c = [];
    ceq = [x(1) - 1];
  end
end