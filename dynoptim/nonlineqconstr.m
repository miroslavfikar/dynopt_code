function [Mceq,DMceq] = nonlineqconstr(optim_param,lim,um,xm,pm,tfull)
% NONLINEQCONSTR - returns the values of nonlinear equality constraints for
% process states given by the orthogonal collocation method following
% discretised differential equations in each collocation point: 
% M*dx(t_i) - li(i)*f(t_i,x_i,u_i,p_i)
% and the values of nonlinear equality constraints for initial condition
% for process states, following:
% x(t_0) - x_0(p) = 0
% where initial states can be a function of time independent parameters p.

% This function is used in cmconfun and cmconfungrad functions.


% initialisation of variables
%..........................................................................
% gives information about rows of ceq_pom vector and Dceqxy_pom matrixes
% nx nonlinear equality constraints at each collocation point
ceq_row = optim_param.nx; 

% constraints calculated at each collocation point
ceq_temp = zeros(ceq_row,1); 

% output vector Mceq: constraints over full interval ]t0,tf[
Mceq = []; 

if nargout == 2 % DMceq is also calculed
    % output matrix DMceq: gradients of constraints over full interval ]t0,tf[
    DMceq = []; 
    % gradients of length of intervals with respect to themselves
    dlidli = eye(optim_param.ni); % ni-by-ni matrix
end

% additional variables
nuj = optim_param.nu*optim_param.ncolu;
nxj = optim_param.nx*(optim_param.ncolx+1);
%..........................................................................

% calculus
for i = 1:optim_param.ni
    if nargout == 2 % DMceq is also calculed
        % gradient of time with respect to the lengths of intervals
        dtdli = dercoltime(optim_param.tau,optim_param.ni,i);
    end
    
    % initial condition: x10 - x0(p) = 0 
    %......................................................................
    if i == 1 
        % calculus of t_c, x_c, u_c, p_c
        [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm,1,1);
        
        % x10 - x0 = 0 && x0 = f(p)
        %..................................................................
        % nx-by-1 vector
        x10 = reshape(xm(:,i),optim_param.ncolx+1,optim_param.nx)'...
             *optim_param.lfx(1,:)'; 
        % nx-by-1 vector
        x0 = feval(optim_param.process,t_c,x_c,5,u_c,p_c); 
        ceq_temp(:) = x10 - x0; 
        %..................................................................
        
        % filling vector Mceq with constraints in given collocation point
        Mceq = [Mceq;ceq_temp];
        
        % gradient calculus
        %..................................................................
        if nargout == 2 % DMceq is also calculed
            % initialisation of variables
            %..............................................................
            Dceqt_temp = zeros(ceq_row,optim_param.dt_col); % gradient matrixes
            Dcequ_temp = zeros(ceq_row,optim_param.du_col); % of ceq_pom with 
            Dceqx_temp = zeros(ceq_row,optim_param.dx_col); % respect to optimised
            Dceqp_temp = zeros(ceq_row,optim_param.dp_col); % parameters: t, x, u, p
            %..............................................................
            
            % d(x10 - x0)/dxij
            %..............................................................
            % nx-by-nx*(ncolx+1) matrix
            dx10dxij = kron(eye(optim_param.nx),optim_param.lfx(1,:));
            Dceqx_temp(:,(i-1)*nxj+1:i*nxj) = dx10dxij;
            %..............................................................
            
            % d(x10 - x0)/dp
            %..............................................................
            if optim_param.dp_col ~= 0 % p is optimised variable
                % np-by-nx matrix or []
                dx0dp = feval(optim_param.process,t_c,x_c,6,u_c,p_c); 
                if isempty(dx0dp)
                    dx0dp = zeros(optim_param.np,optim_param.nx);
                end
                Dceqp_temp(:,:) = -dx0dp';
            end
            %..............................................................
            
            % filling matrix DMceq with gradients in given collocation
            % point
            Dceq_temp = [Dceqt_temp Dcequ_temp Dceqx_temp Dceqp_temp];
            DMceq = [DMceq;Dceq_temp];
        end
        %..................................................................
    end
    %......................................................................

    % Discretisation: M*dx(t_i) - li(i)*f(t_i,x_i,u_i,p_i)
    %......................................................................    
    for j = 2:optim_param.ncolx+1 
        % calculus of t_c, x_c, u_c, p_c
        [t_c,x_c,u_c,p_c] = evalcollpoint(optim_param,tfull,xm,um,pm,i,j);
                
        % nonlinear equality constraints
        % Mdx(t_i) - delta_zeta(i)*f(t_i,x_i,u_i,p_i)
        %..................................................................
        % nx-by-1 vector
        dx = reshape(xm(:,i),optim_param.ncolx+1,optim_param.nx)'...
            *optim_param.dlfx(j,:)'; 
        % nx-by-1 vector
        f = feval(optim_param.process,t_c,x_c,0,u_c,p_c); 
        ceq_temp(:) = optim_param.M*dx - lim(i)*f; 
        %..................................................................
        
        % filling vector Mceq with constraints in given collocation point
        Mceq = [Mceq;ceq_temp];
        
        % gradient calculus
        %..................................................................
        if nargout == 2 % DMceq is also calculed
            % initialisation of variables
            %..............................................................
            Dceqt_temp = zeros(ceq_row,optim_param.dt_col); % gradient matrixes
            Dcequ_temp = zeros(ceq_row,optim_param.du_col); % of ceq_pom with 
            Dceqx_temp = zeros(ceq_row,optim_param.dx_col); % respect to optimised
            Dceqp_temp = zeros(ceq_row,optim_param.dp_col); % parameters: t, x, u, p
            %..............................................................
            
            % d(Mdx(t_i) - delta_zeta(i)*f(t_i,x_i,u_i,p_i))/ddelta_zeta
            %..............................................................
            if optim_param.dt_col ~= 0 % t is optimised variable
                % 1-by-nx matrix or []
                dfdt = feval(optim_param.process,t_c,x_c,4,u_c,p_c); 
                if isempty(dfdt)
                    dfdt = zeros(1,optim_param.nx);
                end
                Dceqt_temp(:,:) = -f*dlidli(:,i)' - lim(i)*dfdt'*dtdli(:,j)';
            end
            %..............................................................
            
            % d(Mdx(t_i)-delta_zeta(i)*f(t_i,x_i,u_i,p_i))/duij
            %..............................................................
            if optim_param.du_col ~= 0 % u is optimised variable
                % nu-by-nx matrix or []
                dfdu = feval(optim_param.process,t_c,x_c,2,u_c,p_c); 
                if isempty(dfdu)
                    dfdu = zeros(optim_param.nu,optim_param.nx);
                end
                % nu-by-nu*ncolu matrix
                duduij = kron(eye(optim_param.nu),optim_param.lfu(j,:)); 
                Dcequ_temp(:,(i-1)*nuj+1:i*nuj) = -lim(i)*dfdu'*duduij;
            end
            %..............................................................
            
            % d(Mdx(t_i) - delta_zeta(i)*f(t_i,x_i,u_i,p_i))/dxij
            %..............................................................
            % x is always optimised variable
            % nx-by-nx*(ncolx+1) matrix
            ddxdxij = kron(eye(optim_param.nx),optim_param.dlfx(j,:)); 
            % nx-by-nx matrix
            dfdx = feval(optim_param.process,t_c,x_c,1,u_c,p_c); 
            % nx-by-nx*(ncolx+1) matrix
            dxdxij = kron(eye(optim_param.nx),optim_param.lfx(j,:)); 
            Dceqx_temp(:,(i-1)*nxj+1:i*nxj) = optim_param.M*ddxdxij ...
                - lim(i)*dfdx'*dxdxij;
            %..............................................................
            
            % d(Mdx(t_i)-delta_zeta(i)*f(t_i,x_i,u_i,p_i))/dp
            %..............................................................
            if optim_param.dp_col ~= 0 % p is optimised variable
                % np-by-nx matrix or []
                dfdp = feval(optim_param.process,t_c,x_c,3,u_c,p_c); 
                if isempty(dfdp)
                    dfdp = zeros(optim_param.np,optim_param.nx);
                end
                Dceqp_temp(:,:) = -lim(i)*dfdp';
            end
            %..............................................................
            
            % filling matrix DMceq with gradients in given collocation
            % point
            Dceq_temp = [Dceqt_temp Dcequ_temp Dceqx_temp Dceqp_temp];
            DMceq = [DMceq;Dceq_temp];
        end
        %..................................................................
    end
end
%--------------------------------------------------------------------------