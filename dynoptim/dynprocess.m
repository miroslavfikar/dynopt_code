function sys = dynprocess(t,x,flag,u,p,param)

switch flag
    case 0 % f(x,u,p,t)
        sys = param.origprocess(t,x,u,p,flag);      
    case 1 % df/dx
        sys = dgrad_process(t,x,u,p,flag, param);
% 	sys = processd(t,x,u,p,flag);
    case 2 % df/du
        sys = dgrad_process(t,x,u,p,flag, param);
%	sys = processd(t,x,u,p,flag);
    case 3 % df/dp
        sys = dgrad_process(t,x,u,p,flag, param);
%	sys = processd(t,x,u,p,flag);
    case 4 % df/dt
        sys = dgrad_process(t,x,u,p,flag, param);
%	sys = processd(t,x,u,p,flag);      
    case 5 % x0
        sys = param.origprocess(t,x,u,p,flag);
    case 6 % dx0/dp
        sys = dgrad_process(t,x,u,p,flag, param);
%	sys = processd(t,x,u,p,flag);
%    case 7 % M
%        sys = param.origprocess(t,x,u,p,flag);
    case 8 % unused flag
        sys = [];
    otherwise
        error(['unhandled flag = ',num2str(flag)]); 
end
%sys = processd(t,x,u,p,flag);      
