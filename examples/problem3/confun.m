function [c,ceq,Dc,Dceq] = confun(t,x,flag,u,p)

switch flag
    case 0 % constraints in t0
        c = [];
        ceq = [];
        
        % gradient calculus
        if nargout == 4
            Dc.t = [];
            Dc.x = [];
            Dc.u = [];
            Dc.p = [];
            Dceq.t = [];
            Dceq.x = [];
            Dceq.u = [];
            Dceq.p = [];
        end
    case 1 % constraints over interval [t0,tf]
        c = [x(2)-8*(t-0.5)^2+0.5];
        ceq = [];
        
        % gradient calculus
        if nargout == 4
            Dc.t = [-16*t+8];
            Dc.x = [0;1;0];
            Dc.u = [];
            Dc.p = [];
            Dceq.t = [];
            Dceq.x = [];
            Dceq.u = [];
            Dceq.p = [];
        end
    case 2 % constraints in tf
        c = [];
        ceq = [];
        
        % gradient calculus   
        if nargout == 4
            Dc.t = [];
            Dc.x = [];
            Dc.u = [];
            Dc.p = [];
            Dceq.t = [];
            Dceq.x = [];
            Dceq.u = [];
            Dceq.p = [];
        end
end