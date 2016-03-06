function [A,b] = liniconstr(optim_param)
% LINICONSTR - returns returns m-by-n matrix A and m-by-1 vector b for
% linear inequality constraints to NLP solver fmincon, where m represents a
% number of constraints, n represents number of optimised variables.  

% This function is used in dynopt function.


% calculation of variations of boundary conditions
% gives later information about rows of matrices Axy
%..........................................................................
if ~isempty(optim_param.bdt) % bounds to t are given 
    dt_row = optim_param.ni; 
else
    dt_row = 0;
end

if ~isempty(optim_param.bdu) % bounds to u are given
    du_row = optim_param.nu*2; 
else
    du_row = 0;
end

if ~isempty(optim_param.bdx) % bounds to x are given
    dx_row = optim_param.nx*2; 
else
    dx_row = 0;
end

if ~isempty(optim_param.bdp) % bounds to p are given
    dp_row = optim_param.np*2;
else
    dp_row = 0;
end
%..........................................................................
    
% partial derivatives of lengths of intervals with respect to themselves
dlidli = eye(optim_param.ni);

% partial derivatives of parameters with respect to themselves
dpdp = eye(optim_param.np);

% output matrix A and output vector b
A = []; b = [];

% additional variables
nuj = optim_param.nu*optim_param.ncolu;
nxj = optim_param.nx*(optim_param.ncolx+1);

for i = 1:optim_param.ni % cycle for each interval
    % initialisation of variables
    %......................................................................
    Att = zeros(2,optim_param.dt_col); % matrices for optimised 
    Atu = zeros(2,optim_param.du_col); % lengths of intervals
    Atx = zeros(2,optim_param.dx_col); %
    Atp = zeros(2,optim_param.dp_col); %
    bt = zeros(2,1);  
    Aut = zeros(du_row,optim_param.dt_col); % matixes for optimised
    Auu = zeros(du_row,optim_param.du_col); % control variables
    Aux = zeros(du_row,optim_param.dx_col); %
    Aup = zeros(du_row,optim_param.dp_col); %
    bu = zeros(du_row,1);                   %
    Axt = zeros(dx_row,optim_param.dt_col); % matrices for optimised
    Axu = zeros(dx_row,optim_param.du_col); % state variables
    Axx = zeros(dx_row,optim_param.dx_col); %
    Axp = zeros(dx_row,optim_param.dp_col); %
    bx = zeros(dx_row,1);                   %
    Apt = zeros(dp_row,optim_param.dt_col); % matrices for optimised
    Apu = zeros(dp_row,optim_param.du_col); % parameters
    Apx = zeros(dp_row,optim_param.dx_col); %
    App = zeros(dp_row,optim_param.dp_col); %
    bp = zeros(dp_row,1);                   % 
    %......................................................................
    
    % cycle for each collocation point in given interval
    for j = 1:optim_param.ncolx+2 
        % bounds to u are given 
        % the following two equations should be calculated in each
        % collocation point: -u_ij <= -u_ij^L, u_ij <= u_ij^U 
        %..................................................................
        if du_row ~= 0 
            % -u_ij <= -u_ij^L
            duduij = kron(eye(optim_param.nu),optim_param.lfu(j,:));
            Auu(1:optim_param.nu,(i-1)*nuj+1:i*nuj) = -duduij;
            % -u_ij^L
            if size(optim_param.bdu,2) == 2
              bu(1:optim_param.nu,1) = -optim_param.bdu(:,1); 
            else
	     bu(1:optim_param.nu,1) = -optim_param.bdu(:,(i-1)+i);
            end 
            
            % u_ij <= u_ij^U
            Auu(optim_param.nu+1:2*optim_param.nu,(i-1)*nuj+1:i*nuj) = duduij;
            % u_ij^U
            if size(optim_param.bdu,2) == 2
              bu(optim_param.nu+1:2*optim_param.nu,1) = optim_param.bdu(:,2);
            else              
              bu(optim_param.nu+1:2*optim_param.nu,1) = optim_param.bdu(:,2*i);
            end
        end
        %..................................................................
        
        % bounds to x are given
        % the following two equations should be calculated in each
        % collocation point: -x_ij <= -x_ij^L, x_ij <= x_ij^U
        %..................................................................
        if dx_row ~= 0 
            % -x_ij <= -x_ij^L
            dxdxij = kron(eye(optim_param.nx),optim_param.lfx(j,:));
            Axx(1:optim_param.nx,(i-1)*nxj+1:i*nxj) = -dxdxij;
            % -x_ij^L
            if size(optim_param.bdx,2) == 2
              bx(1:optim_param.nx,1) = -optim_param.bdx(:,1); 
            else
	      bx(1:optim_param.nx,1) = -optim_param.bdx(:,(i-1)+i);
            end 

            % x_ij <= x_ij^U
            Axx(optim_param.nx+1:2*optim_param.nx,(i-1)*nxj+1:i*nxj) = dxdxij;
            % x_ij^U
            if size(optim_param.bdx,2) == 2
              bx(optim_param.nx+1:2*optim_param.nx,1) = optim_param.bdx(:,2);
            else             
              bx(optim_param.nx+1:2*optim_param.nx,1) = optim_param.bdx(:,2*i);
            end 
        end
        %..................................................................
        
        % filling matrix A and vector b with the constriants to u and x in
        % each collocation point over given interval
        A = [A;Aut Auu Aux Aup;Axt Axu Axx Axp]; 
        b = [b;bu;bx]; 
    
        % the last collocation point is also element knot (t_i)
        if j == optim_param.ncolx+2 
            % bounds to t are given
            % the following two equations should be calculated in each
            % element knot, the last collocation point in each interval:
            % -fi_ij <= -fi_ij^L, fi_ij <= fi_ij^U  
            %..................................................................
            if dt_row ~= 0 
                % -fi_i <= -fi_i^L 
                Att(1,:) = -dlidli(i,:);
                % -fi_i^L
                bt(1,1) = -optim_param.bdt(1,1); 
              
                % fi_i <= fi_i^U 
                Att(2,:) = dlidli(i,:);
                % fi_i^U
                bt(2,1) = optim_param.bdt(1,2); 
            end
            %..................................................................
            
            % filling matrix A and vector b with the constraints to element
            % lengths in end of each interval/in each element knot
            A = [A;Att Atu Atx Atp];
            b = [b;bt];
        end
    end
end

% bounds to p are given
% the following two equations should be calculated: -p <= -p^L, p <= p^U
%..........................................................................
if dp_row ~= 0 
    % -p <= -p^L 
    App(1:optim_param.np,:) = -dpdp;
    % -p^L
    bp(1:optim_param.np,1) = -optim_param.bdp(:,1); 

    % p <= p^U 
    App(optim_param.np+1:2*optim_param.np,:) = dpdp;
    % p^U
    bp(optim_param.np+1:2*optim_param.np,1) = optim_param.bdp(:,2); 
end
%..........................................................................

% filling matrix A and vector b with the constraints to parameters
A = [A;Apt Apu Apx App];
b = [b;bp];
if (isempty(A) && isempty(b))
    A = []; b = [];
end
%--------------------------------------------------------------------------