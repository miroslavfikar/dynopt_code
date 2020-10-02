function [c,ceq] = confun(t,x,flag,u,p)
if flag == 0       
    c = [];
    ceq = [];
elseif flag == 1    
    c = [-x(1);x(1)-1;-x(2);x(2)-1;-x(3);x(3)-1];
    ceq = [];
elseif flag == 2       
    c = [];
    ceq = [];
end
end