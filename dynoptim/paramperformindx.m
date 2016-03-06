function [pf,pDf] = paramperformindx(tfull,xm,um,pm,optim_param)
% PARAMPERFORMINDX - returns the value of user given objective function for
% tracking problems and its gradients with respect to all optimisation
% variables (li,uij,xij,par) in given collocation point.

% This function is used in cmobjfun, cmobjfungrad functions.

% additional variables
nuj = optim_param.nu*optim_param.ncolu;
nxj = optim_param.nx*(optim_param.ncolx+1);

tmes = optim_param.objtype.tm; xmes = optim_param.objtype.xm;

pf = 0;
if nargout == 2
    pDf = [];
end

% initialisation of variables for calculus of gradients 
if nargout == 2 
    f_row = 1;
    Dft_temp = zeros(f_row,optim_param.dt_col);
    Dfu_temp = zeros(f_row,optim_param.du_col);
    Dfx_temp = zeros(f_row,optim_param.dx_col);
    Dfp_temp = zeros(f_row,optim_param.dp_col);
end

for i = 1:length(tmes) 
    % actual element value and corresponding measured states
    t_m = tmes(i);
    x_m = xmes(:,i);
    
    [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm,t_m, ...
        optim_param.ncolx+2);
    if nargout == 1
        [f] = feval(optim_param.objfun,t_c,x_c,u_c,p_c,x_m);
    else
        [f,Df] = feval(optim_param.objfun,t_c,x_c,u_c,p_c,x_m);
    end
    
    % user defined objective function in given element knot
    pf = pf + f;
    
    if nargout == 2
        % gradient of time with respect to the lengths of intervals
        dtdli = dercoltime(optim_param.tau,optim_param.ni,i);
        
        % gradients of user defined objective function with respect to the
        % element lengths, xij, uij, p
        if ~isempty(Df.t)
            Dft_temp(:,:) = Df.t'*dtdli(:,optim_param.ncolx+2)';
        end
        
        if ~isempty(Df.u)
            % nu-by-nu*ncolu matrix
            duduij = kron(eye(optim_param.nu),optim_param.lfu(optim_param.ncolx+2,:));
            Dfu_temp(:,(i-1)*nuj+1:i*nuj) = Df.u'*duduij;
        end
        
        if ~isempty(Df.x)
            % nx-by-nx*(ncolx+1) matrix
            dxdxij = kron(eye(optim_param.nx),optim_param.lfx(optim_param.ncolx+2,:));
            Dfx_temp(:,(i-1)*nxj+1:i*nxj) = Df.x'*dxdxij;
        end
        
        if ~isempty(Df.p)
            Dfp_temp(:,:) = Df.p';
        end
       
        % user defined gradients of objective function
        pDf = [Dft_temp Dfu_temp Dfx_temp Dfp_temp];
    end
end
%--------------------------------------------------------------------------