function sys = dynprocess(t,x,flag,u,p)

switch flag
    case 0 % f(x,u,p,t)
        sys = process(t,x,u,p,flag);      
    case 1 % df/dx
        [~,JacX,~,~] = dgrad_process(t,x,u,p,flag);
        sys = JacX;
% 	sys = processd(t,x,u,p,flag);
% 	if norm(sys1-sys) > 1e-6
% 	  t,x,u
% 	  sys1
% 	  sys
% 	end
    case 2 % df/du
        [~,~,JacU,~] = dgrad_process(t,x,u,p,flag);
        sys = JacU;
%	sys = processd(t,x,u,p,flag);
    case 3 % df/dp
        [~,~,~,JacP] = dgrad_process(t,x,u,p,flag);
        sys = JacP;
%	sys = processd(t,x,u,p,flag);
    case 4 % df/dt
        [JacT,~,~,~] = dgrad_process(t,x,u,p,flag);
        sys = JacT;
%	sys = processd(t,x,u,p,flag);      
    case 5 % x0
        sys = process(t,x,u,p,flag);
    case 6 % dx0/dp
        [~,~,~,JacP] = dgrad_process(t,x,u,p,flag);
        sys = JacP;
%	sys = processd(t,x,u,p,flag);
    case 7 % M
        sys = process(t,x,u,p,flag);
    case 8 % unused flag
        sys = [];
    otherwise
        error(['unhandled flag = ',num2str(flag)]); 
end
%sys = processd(t,x,u,p,flag);      
