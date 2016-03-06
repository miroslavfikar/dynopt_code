function [Uc,Uceq,DUc,DUceq] = userconst(optim_param,t_c,x_c,flag,u_c,p_c,i,j)
% USERCONST - returns by user given constraints and their gradients with
% respect to all optimisation variables (li,uij,xij,par) in given
% collocation point.


% additional variables
nuj = optim_param.nu*optim_param.ncolu;
nxj = optim_param.nx*(optim_param.ncolx+1);

% gradient of time with respect to the lengths of intervals
dtdli = dercoltime(optim_param.tau,optim_param.ni,i);

% user defined equality and inequality constraints and their gradients
if nargout == 2
    [c,ceq] = feval(optim_param.confun,t_c,x_c,flag,u_c,p_c);
else 
    [c,ceq,Dc,Dceq] = feval(optim_param.confun,t_c,x_c,flag,u_c,p_c);
end

% user defined constraints in given collocation point
Uc = c;
Uceq = ceq;

% initialisation of variables for calculus of gradients
%..........................................................................
if nargout == 4
    c_row = length(c);
    ceq_row = length(ceq);
    Dct_temp = zeros(c_row,optim_param.dt_col);
    Dcu_temp = zeros(c_row,optim_param.du_col);
    Dcx_temp = zeros(c_row,optim_param.dx_col);
    Dcp_temp = zeros(c_row,optim_param.dp_col);
    Dceqt_temp = zeros(ceq_row,optim_param.dt_col);
    Dcequ_temp = zeros(ceq_row,optim_param.du_col);
    Dceqx_temp = zeros(ceq_row,optim_param.dx_col);
    Dceqp_temp = zeros(ceq_row,optim_param.dp_col);
    
    % gradients of user defined inequality constraints with respect to the
    % element lengths, xij, uij, p
    %......................................................................
    if ~isempty(Dc.t)
        Dct_temp(:,:) = Dc.t'*dtdli(:,j)';
    end
    
    if ~isempty(Dc.u)
        % nu-by-nu*ncolu matrix
        duduij = kron(eye(optim_param.nu),optim_param.lfu(j,:));
        Dcu_temp(:,(i-1)*nuj+1:i*nuj) = Dc.u'*duduij;
    end
    
    if ~isempty(Dc.x)
        % nx-by-nx*(ncolx+1) matrix
        dxdxij = kron(eye(optim_param.nx),optim_param.lfx(j,:));
        Dcx_temp(:,(i-1)*nxj+1:i*nxj) = Dc.x'*dxdxij;
    end
    
    if ~isempty(Dc.p)
        Dcp_temp(:,:) = Dc.p';
    end
    %......................................................................
    
    % gradients of user defined equality constraints with respect to the
    % element lengths, xij, uij, p
    %......................................................................
    if ~isempty(Dceq.t)
        Dceqt_temp(:,:) = Dceq.t'*dtdli(:,j)';
    end
    
    if ~isempty(Dceq.u)
        % nu-by-nu*ncolu matrix
        duduij = kron(eye(optim_param.nu),optim_param.lfu(j,:));
        Dcequ_temp(:,(i-1)*nuj+1:i*nuj) = Dceq.u'*duduij;
    end
    
    if ~isempty(Dceq.x)
        % nx-by-nx*(ncolx+1) matrix
        dxdxij = kron(eye(optim_param.nx),optim_param.lfx(j,:));
        Dceqx_temp(:,(i-1)*nxj+1:i*nxj) = Dceq.x'*dxdxij;
    end
    
    if ~isempty(Dceq.p)
        Dceqp_temp(:,:) = Dceq.p';
    end 
    %......................................................................
    
    % user defined gradients of constraints in given collocation point
     DUc = [Dct_temp Dcu_temp Dcx_temp Dcp_temp];
     DUceq = [Dceqt_temp Dcequ_temp Dceqx_temp Dceqp_temp];
end
%--------------------------------------------------------------------------