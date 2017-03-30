function sys = process(t,x,flag,u,p)

switch flag
    case 0 % f(x,u,p,t)
        sys = process_function(t,x,u,p,flag);      
    case 1 % df/dx
        [~,JacX,~,~] = dgrad_process(t,x,u,p,flag);
        sys = JacX;
    case 2 % df/du
        [~,~,JacU,~] = dgrad_process(t,x,u,p,flag);
        sys = JacU;
    case 3 % df/dp
        [~,~,~,JacP] = dgrad_process(t,x,u,p,flag);
        sys = JacP;
    case 4 % df/dt
        [JacT,~,~,~] = dgrad_process(t,x,u,p,flag);
        sys = JacT;
    case 5 % x0
        sys = process_function(t,x,u,p,flag);
    case 6 % dx0/dp
        [~,~,~,JacP] = dgrad_process(t,x,u,p,flag);
        sys = JacP;
    case 7 % M
        sys = process_function(t,x,u,p,flag);
    case 8 % unused flag
        sys = [];
    otherwise
        error(['unhandled flag = ',num2str(flag)]); 
end