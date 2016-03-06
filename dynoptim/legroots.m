function tauk = legroots(ncol)
% LEGROOTS - returns the values of the shifted roots of Legendre polynomial
% of order NCOL for interval ]0,1[.
%
%   [TAUK] = legroots(NCOL) solves the Legendre polynomial of order NCOL,
%   as follows:
%       P_0 = 1 
%       P_1 = 2x - 1 
%       ... 
%               4k-2      2k-1           k-1   
%       P_k = (------x - ------)P_k-1 - -----P_k-2, where k=ncol
%                 k         k              k 
%   and returns an NCOL-by-1 vector TAUK of times in collocation points
%   over interval ]0,1[, the roots of the above mentioned Legendre
%   Polynomial. 


if isempty(ncol)
    errmsg = sprintf('%s %s','Incorrect use of function legroots: ', ...
        'parameter NCOL must be a number.');
    error(errmsg);
end

tauk = flipud(roots(legpol(ncol)));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function coef = legpol(ncol)
% LEGPOL - returns coefficients of the shifted Legendre polynomial. 
%   [COEF] = legpol(NCOL) solves the coeficients of the shifted Legendre
%   polynomial (additional function to legroots(ncol))
%               4k-2      2k-1           k-1   
%       P_k = (------x - ------)P_k-1 - -----P_k-2, where k=ncol
%                 k         k             k 
%   and returns an 1-by-NCOL+1 vector of coefficients of above mentioned
%   polynomial


switch ncol
    case 0 % coefficients of polynomial P_0
        coef = 1;
    case 1 % coefficients of polynomial P_1
        coef = [2 -1];
    otherwise % coefficients of polynomial P_k
        cpp = [1];  % polynomial P_0
        cp = [2 -1]; % polynomial P_1
        for i=2:ncol
            a = (4*i-2)/i; % see P_k: (4k-2)/k
            b = (2*i-1)/i; % see P_k: (2k-1)/k
            c = (i-1)/i; % see P_k: (k-1)/k
            coef1 = a*[cp 0];     % coefficients of polynomial P_k
            coef2 = [0,-b*cp];    % obtained by substituing 
            coef3 = [0,0,-c*cpp]; % polynomials P_k-1 and P_k-2
            coef = coef1 + coef2 + coef3; % the resulting coefficients of P_k
            cpp = cp; % definition of new polynomial P_k-2 = P_k-1
            cp = coef; % definition of new polynomial P_k-1 = P_k
        end
end
%--------------------------------------------------------------------------

