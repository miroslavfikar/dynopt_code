function [fval,grad] = objfun(x,data)

% OBJFUN is used by fminsdp to compute objective function and its 
% gradient. The user-supplied gradient is augmented with an empty sparse
% vector to account for the auxiliary variables used by fminsdp.
%
% See also FMINSDP

nxvars = data.nxvars;

if nargout<2    
    % Call user supplied objective function
    fval = data.objfun(x(1:nxvars,1));
elseif nargout==2
    % Call use supplied objective function to compute gradient
    [fval,grad] = data.objfun(x(1:nxvars,1));
    % Augment gradient with gradient wrt to auxiliary variables
    if data.c>0
        grad = [grad; sparse(data.nLvars,1); data.c];
    else
        grad = [grad; sparse(data.nLvars,1)];
    end        
end

fval = fval + data.c*x(end);