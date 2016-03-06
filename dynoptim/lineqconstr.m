function [Aeq,beq] = lineqconstr(optim_param)
% LINEQCONSTR - returns to the NLP sover fmincon m-by-n matrix Aeq and
% vector m-by-1 beq for linear equality constraints, where m represents
% number of constraints, n represents number of optimised variables.

% This function is used in dynopt function.


% calculation of variations of number of constraints
% gives later information about rows of matrixes Aeqxy
%..........................................................................
% bounds to tf are given | final time condition
if ~isempty(optim_param.tf) 
    dt_row = 1; 
else
    dt_row = 0;
end

% bounds to x are always given | initial and continuity condition
dx_row = optim_param.nx; 
%..........................................................................

% output matrix Aeq and output vector beq
Aeq = []; beq = []; 

% aditional variables
nxj = optim_param.nx*(optim_param.ncolx+1);

% calculus
for i = 1:optim_param.ni % cycle for each interval
    % initialisation of variables
    %......................................................................
    Aeqtt = zeros(dt_row,optim_param.dt_col); % matrixes for optimised tf
    Aeqtu = zeros(dt_row,optim_param.du_col); % 
    Aeqtx = zeros(dt_row,optim_param.dx_col); %
    Aeqtp = zeros(dt_row,optim_param.dp_col); % 
    beqt = zeros(dt_row,1);                   %
    Aeqxt = zeros(dx_row,optim_param.dt_col); % matrixes for optimised state
    Aeqxu = zeros(dx_row,optim_param.du_col); % variables
    Aeqxx = zeros(dx_row,optim_param.dx_col); % 
    Aeqxp = zeros(dx_row,optim_param.dp_col); %
    beqx = zeros(dx_row,1);                   %
    %......................................................................
    
    % contuinuity condition: xi0 - x(i-1)f = 0
    %......................................................................
    if i > 1 
        % the equation xi0 - x(i-1)f = 0 is solved (ni-1) times
        dx0dxij = kron(eye(optim_param.nx),optim_param.lfx(1,:));
        dxfdxij = kron(eye(optim_param.nx),optim_param.lfx(end,:));
        Aeqxx(:,(i-1)*nxj+1:i*nxj) = dx0dxij;
        Aeqxx(:,(i-2)*nxj+1:(i-1)*nxj) = -dxfdxij;
    end
    %......................................................................
    
    % filling matrix Aeq and vector beq with constraints to x
    Aeq = [Aeq;Aeqxt Aeqxu Aeqxx Aeqxp];
    beq = [beq;beqx];
end

% final time condition: sum(li) = tf, where li = lengths of intervals
%..........................................................................
if dt_row ~= 0 
    Aeqtt(:,:) = ones(dt_row,optim_param.dt_col);
    beqt(:) = optim_param.tf; 
end
%..........................................................................

% filling matrix Aeq and vector beq with constraints to t
Aeq = [Aeq;Aeqtt Aeqtu Aeqtx Aeqtp];
beq = [beq;beqt];
%--------------------------------------------------------------------------