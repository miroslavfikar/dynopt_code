function [c,ceq,Dc,Dceq] = confund(t,x,u,p,flag)

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