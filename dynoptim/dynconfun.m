function [c,ceq,Dc,Dceq] = dynconfun(t,x,flag,u,p, param)

  switch flag
   case 0 % constraints in t0
    [c, ceq] = param.origconfun(t,x,u,p,flag);
    
    % gradient calculus         
    if nargout == 4
      % calculating gradients using adigator:
      [JacT, JacX, JacU, JacP] = dgrad_confun(t,x,u,p,flag,c,ceq, param);
      
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
    [c, ceq] = param.origconfun(t,x,u,p,flag);
    
    % gradient calculus         
    if nargout == 4
      % calculating gradients using adigator:
      [JacT, JacX, JacU, JacP] = dgrad_confun(t,x,u,p,flag,c,ceq, param);

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
    [c, ceq] = param.origconfun(t,x,u,p,flag);
   
    % gradient calculus         
    if nargout == 4
      % calculating gradients using adigator:
      [JacT, JacX, JacU, JacP] = dgrad_confun(t,x,u,p,flag,c,ceq, param);
      
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
  
%[c,ceq,Dc,Dceq] = confund(t,x,u,p,flag)