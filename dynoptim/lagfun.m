function [lf,dlf] = lagfun(tau,tauk)
% LAGFUN - returns values of Lagrange function computed for normalised
% interval [0,1].
%
%   [LF] = lagfun(TAU,TAUK) takes the values of times in collocation
%   points in a) ncolx+1-by-1 or b)ncolu-by-1 vector TAUK and the values of
%   times in column vector TAU in which the Lagrange function has to be 
%   evaluated as follows: 
%             ncol    (tau - tau_k)              ncol    (tau - tau_k)
%   a) lfx = product ---------------,  b) lfu = product ---------------
%             k=0,j  (tau_j - tau_k)             k=1,j  (tau_j - tau_k)
%   and returns an m-by-n matrix of the values of Lagrange function
%   evaluated in normalised times TAU, where ncolx represents number of
%   collocation points for state variables, ncolu represents number of
%   collocation points for control variables, m is length of vector TAU, 
%   n is length of vector TAUK.    
%
%   [LF,DLF] = lagfun(TAU,TAUK) takes all as above and returns also an
%   m-by-n matrix DLF of the values of the derivatives of the Lagrange
%   function with respect to dimensionless time TAU evaluated in this time.   


% input and output number of parameters verify
if (~isnumeric(tau) || ~isnumeric(tauk))
    errmsg = sprintf('%s %s','Incorrect use of function lagfun: ', ...
        'parameter TAU or TAUK must be a numeric array.');
    error(errmsg);
elseif ((isnumeric(tau) && isempty(tau)) || (isnumeric(tauk) && isempty(tauk)))
    errmsg = sprintf('%s %s','Incorrect use of function lagfun: ', ...
        'parameter TAU or TAUK should be a number or array of numbers.');
    error(errmsg);
end

% calculus
%..........................................................................
% calculation of length of tau and tauk
temp = length(tau);
lp = length(tauk); 

% initialisation of the Lagrange function matrixes
lf = zeros(temp,lp); 
if nargout == 2 % the derivative is calculed
    dlf = zeros(temp,lp); 
end

% cykle to evaluate Lagrange function in each time in tau        
for j=1:temp 
    % initialisation of the Lagrange function vectors
    lf_temp = ones(lp,1); 
    if nargout == 2 % the derivative is calculed
        dlf_temp = zeros(lp,1);
    end
    
    % cykle to calcul Lagrange function vector and its derivative
    for i=1:lp
        for m=1:lp 
            if m~=i
                if nargout == 2 % the derivative is calculed
                    dlf_temp(i) = dlf_temp(i)*(tau(j)-tauk(m))/(tauk(i)-tauk(m));
                    dlf_temp(i) = dlf_temp(i)+lf_temp(i)/(tauk(i)-tauk(m));
                end
                lf_temp(i) = lf_temp(i)*(tau(j)-tauk(m))/(tauk(i)-tauk(m));
            end
        end
    end
    
    % filling the matrixes with vector values
    lf(j,:) = lf_temp'; 
    if nargout == 2
        dlf(j,:) = dlf_temp'; 
    end
end
%..........................................................................
%--------------------------------------------------------------------------