function [c,ceq,Dc,Dceq] = confun(t,x,flag,u,p)
% CONFUN - with respect to flag returns user given inequality and equality
% constraint vectors and their derivatives with respect to time t, states
% x, controls u, and parameters p.
%
% Parameter flag separates the constraints into constraints implemented in
% time t0, into constraints implemented over full time interval [t0,tf],
% and into constraints implemented in time tf.


switch flag
    % If you have constraints to implement in time t0, fill this part of
    % function
    case 0 % constraints in t0
        c = [];
        ceq = [];
        
        % gradient calculus
        if nargout == 4
            Dc.t = [];
            Dc.x = [];
            Dc.u = [];
            Dc.p = [];
            Dceq.t = [];
            Dceq.x = [];
            Dceq.u = [];
            Dceq.p = [];
        end
    % If you have constraints to implement over full time interval [t0,tf],
    % fill this part of function
    case 1 % constraints over interval [t0,tf]
        c = [];
        ceq = [];
        
        % gradient calculus
        if nargout == 4
            Dc.t = [];
            Dc.x = [];
            Dc.u = [];
            Dc.p = [];
            Dceq.t = [];
            Dceq.x = [];
            Dceq.u = [];
            Dceq.p = [];
        end
    % If you have constraints to implement in time tf, fill this part of
    % function
    case 2 % constraints in tf
        c = [];
        ceq = [];
        
        % gradient calculus   
        if nargout == 4
            Dc.t = [];
            Dc.x = [];
            Dc.u = [];
            Dc.p = [];
            Dceq.t = [];
            Dceq.x = [];
            Dceq.u = [];
            Dceq.p = [];
        end
end