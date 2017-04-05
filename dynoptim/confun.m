function [c,ceq,Dc,Dceq] = confun(t,x,flag,u,p)

switch flag
    case 0 % constraints in t0
        [c, ceq] = confun_function(t,x,u,p,flag);
        
        % calculating gradients using adigator:
        [JacT, JacX, JacU, JacP] = dgrad_confun(t,x,u,p,flag,c,ceq);

        % gradient calculus         
        if nargout == 4
            Dc.t = JacT.c;
            Dc.x = JacX.c;
            Dc.u = JacU.c;
            Dc.p = JacP.c;
            Dceq.t = JacT.ceq;
            Dceq.x = JacX.ceq;
            Dceq.u = JacU.ceq;
            Dceq.p = JacP.ceq;
        end
    case 1 % constraints over interval [t0,tf]
        [c, ceq] = confun_function(t,x,u,p,flag);
        
         % calculating gradients using adigator:
        [JacT, JacX, JacU, JacP] = dgrad_confun(t,x,u,p,flag,c,ceq);

        % gradient calculus         
        if nargout == 4
            Dc.t = JacT.c;
            Dc.x = JacX.c;
            Dc.u = JacU.c;
            Dc.p = JacP.c;
            Dceq.t = JacT.ceq;
            Dceq.x = JacX.ceq;
            Dceq.u = JacU.ceq;
            Dceq.p = JacP.ceq;
        end
    case 2 % constraints in tf
        [c, ceq] = confun_function(t,x,u,p,flag);
        
         % calculating gradients using adigator:
        [JacT, JacX, JacU, JacP] = dgrad_confun(t,x,u,p,flag,c,ceq);

        % gradient calculus         
        if nargout == 4
            Dc.t = JacT.c;
            Dc.x = JacX.c;
            Dc.u = JacU.c;
            Dc.p = JacP.c;
            Dceq.t = JacT.ceq;
            Dceq.x = JacX.ceq;
            Dceq.u = JacU.ceq;
            Dceq.p = JacP.ceq;
        end
 end