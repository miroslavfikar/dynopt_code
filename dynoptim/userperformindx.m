function [Uf,DUf] = userperformindx(optim_param,t_c,x_c,u_c,p_c,i,j)
% USERPERFORMINDX - returns the value of user given objective function and
% its gradients with respect to all optimisation variables (li,uij,xij,par)
% in given collocation point.

% This function is used in cmobjfun, cmobjfungrad functions.


% additional variables
nuj = optim_param.nu*optim_param.ncolu;
nxj = optim_param.nx*(optim_param.ncolx+1);

% gradient of time with respect to the lengths of intervals
dtdli = dercoltime(optim_param.tau,optim_param.ni,i);

% user defined equality and inequality constraints and their gradients
if nargout == 1
    [f] = feval(optim_param.objfun,t_c,x_c,u_c,p_c);
else 
    [f,Df] = feval(optim_param.objfun,t_c,x_c,u_c,p_c);
end

% user defined constraints in given collocation point
Uf = f;

% initialisation of variables for calculus of gradients
%..........................................................................
if nargout == 2
    f_row = length(f);
    Dft_temp = zeros(f_row,optim_param.dt_col);
    Dfu_temp = zeros(f_row,optim_param.du_col);
    Dfx_temp = zeros(f_row,optim_param.dx_col);
    Dfp_temp = zeros(f_row,optim_param.dp_col);
    
    % gradients of user defined objective function with respect to the
    % element lengths, xij, uij, p
    if ~isempty(Df.t)
        Dft_temp(:,:) = Df.t'*dtdli(:,j)';
    end
    
    if ~isempty(Df.u)
        % nu-by-nu*ncolu matrix
        duduij = kron(eye(optim_param.nu),optim_param.lfu(j,:));
        Dfu_temp(:,(i-1)*nuj+1:i*nuj) = Df.u'*duduij;
    end
    
    if ~isempty(Df.x)
        % nx-by-nx*(ncolx+1) matrix
        dxdxij = kron(eye(optim_param.nx),optim_param.lfx(j,:));
        Dfx_temp(:,(i-1)*nxj+1:i*nxj) = Df.x'*dxdxij;
    end
    
    if ~isempty(Df.p)
        Dfp_temp(:,:) = Df.p';
    end

    % user defined gradients of objective function in given collocation point
     DUf = [Dft_temp Dfu_temp Dfx_temp Dfp_temp];
 end
%--------------------------------------------------------------------------