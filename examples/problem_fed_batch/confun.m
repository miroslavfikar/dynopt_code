function [c,ceq] = confun(t,x,flag,u,p)
if flag == 0
    c = [];
    ceq = [];
elseif flag == 1
    c = [];
    ceq = [];
elseif flag == 2
    c = [x(4)-200];
    ceq = [];
end
end