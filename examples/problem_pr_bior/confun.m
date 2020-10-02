function [c, ceq] = confun(t, x, flag, u, p)
if flag == 0
    c = [x(1) - x(2)];
    ceq = [];
elseif flag == 1
    c = [x(1) - x(2)];
    ceq = [];
elseif flag == 2
    c = [x(1) - x(2)];
    ceq = [];
end
end