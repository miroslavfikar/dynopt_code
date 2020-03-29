function [JacT, JacX, JacU, JacP] = dgrad_process( t, x, u, p, flag, param )

% gradients of process model \wrt to time (t)
if (~isempty(t))
    t_time = struct('f',t,'dt',ones(length(t),1));
    y_t    = param.gradt_process(t_time, x, u, p, flag);
       
    if (isfield(y_t,'dt_size'))
            if (length(y_t.dt_size) == 1)
                gradt   = zeros(y_t.dt_size,1);
                index_t = sub2ind(size(gradt), y_t.dt_location,...
                                  ones(length(y_t.dt_location),1));
                gradt(index_t) = y_t.dt;
            else
                gradt   = zeros(y_t.dt_size);
                index_t = sub2ind(y_t.dt_size, y_t.dt_location(:,1),...
                                               y_t.dt_location(:,2));
                gradt(index_t) = y_t.dt;
            end
    else
        gradt = [];
    end
else
    gradt = [];
end

% gradients of process model \wrt to states (x)
if (~isempty(x))
    states  = struct('f',x,'dx',ones(length(x),1));
    y_x     = param.gradx_process(t, states, u, p, flag);

    if (isfield(y_x,'dx_size'))
       if (length(y_x.dx_size) == 1)
            gradx   = zeros(y_x.dx_size,1);
            index_x = sub2ind(size(gradx), y_x.dx_location,...
                              ones(length(y_x.dx_location),1));
            gradx(index_x) = y_x.dx;
        else
            gradx   = zeros(y_x.dx_size);
            index_x = sub2ind(y_x.dx_size, y_x.dx_location(:,1),...
                                           y_x.dx_location(:,2));
            gradx(index_x) = y_x.dx;
        end
    else
        gradx = [];
    end
else
    gradx = [];
end
    

% gradients of process model \wrt to control (u)
if (~isempty(u))
    control = struct('f',u,'du',ones(length(u),1));
    y_u     = param.gradu_process(t, x, control, p, flag);

    if (isfield(y_u,'du_size'))
        if (length(y_u.du_size) == 1)
            gradu   = zeros(y_u.du_size,1);
            index_u = sub2ind(size(gradu), y_u.du_location,...
                              ones(length(y_u.du_location),1));
            gradu(index_u) = y_u.du;
        else
            gradu   = zeros(y_u.du_size);
            index_u = sub2ind(y_u.du_size, y_u.du_location(:,1),...
                                           y_u.du_location(:,2));
            gradu(index_u) = y_u.du;
        end
    else
        gradu = [];
    end
else
    gradu = [];
end


% gradients of process model \wrt to parameters (p)
if flag == 6
  flag = 5;
end

if (~isempty(p))
    parameter = struct('f',p,'dp',ones(length(p),1));
    y_p     = param.gradp_process(t, x, u, parameter, flag);

    if (isfield(y_p,'dp_size'))
        if (length(y_p.dp_size) == 1)
            gradp   = zeros(y_p.dp_size,1);
            index_p = sub2ind(size(gradp), y_p.dp_location,...
                              ones(length(y_p.dp_location),1));
            gradp(index_p) = y_p.dp;
        else
            gradp   = zeros(y_p.dp_size);
            index_p = sub2ind(y_p.dp_size, y_p.dp_location(:,1),...
                                           y_p.dp_location(:,2));
            gradp(index_p) = y_p.dp;
        end
    else
        gradp = [];
    end
else
    gradp = [];
end

% output : 
JacT = gradt';
JacX = gradx';
JacU = gradu';
JacP = gradp';