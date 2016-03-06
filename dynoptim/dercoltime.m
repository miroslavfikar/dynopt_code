function [dtdli,dtekdli] = dercoltime(tau,ni,i)
% DERCOLTIME - returns the derivative of time in collocation points and the
% derivative of time in the element knots with respect to the lengths of
% intervals for a given element/interval.

% This function is used in cmconfungrad, cmobjfungrad functions.


% derivative of lengths of intervals with respect to themselves
% ni-by-ni matrix
dli_temp = [zeros(ni,1) eye(ni)]';
dli = cumsum(dli_temp);

% derivative of time in interval i with respect to the lengths of intervals
% ni-by-ncolx+2 matrix dt/dli over all time interval [zeta_i-1,zeta_i]
dt_temp = eye(ni);
dtdli = (tau*dt_temp(i,:) + ones(length(tau),1)*dli(i,:))';

if nargout == 2 
    dtekdli = dtdli(:,end);
end
%--------------------------------------------------------------------------