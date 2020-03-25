function [JacT, JacX, JacU, JacP] = dgrad_confun( t, x, u, p, flag, c, ceq, param )
%% gradients of process model \wrt to time (t)
if (~isempty(t))
    t_time         = struct('f',t,'dt',ones(length(t),1));
    [yt_c, yt_ceq] = param.gradt_confun(t_time, x, u, p, flag);

    % inequality constraintes 
    if (isfield(yt_c,'dt_size'))
        if (length(yt_c.dt_size) == 1)
            gradt_c = zeros(yt_c.dt_size,1);
            index_t = sub2ind(size(gradt_c), yt_c.dt_location,...
                              ones(length(yt_c.dt_location),1));
            gradt_c(index_t) = yt_c.dt;
            gradt_c          = gradt_c;
        else
            gradt_c   = zeros(yt_c.dt_size);
            index_t = sub2ind(yt_c.dt_size, yt_c.dt_location(:,1),...
                              yt_c.dt_location(:,2));
            gradt_c(index_t) = yt_c.dt;
            gradt_c          = gradt_c';
        end
    else
        gradt_c = [];
    end
    
    % equality constraintes :
    if (isfield(yt_ceq,'dt_size'))
        if (length(yt_ceq.dt_size) == 1)
            gradt_ceq = zeros(yt_ceq.dt_size,1);
            index_t   = sub2ind(size(gradt_ceq), yt_ceq.dt_location,...
                                ones(length(yt_ceq.dt_location),1));
            gradt_ceq(index_t) = yt_ceq.dt;
            gradt_ceq          = gradt_ceq;
        else
            gradt_ceq   = zeros(yt_ceq.dt_size);
            index_t = sub2ind(yt_ceq.dt_size, yt_ceq.dt_location(:,1),...
                              yt_ceq.dt_location(:,2));
            gradt_ceq(index_t) = yt_ceq.dt;
            gradt_ceq          = gradt_ceq';
        end
    else
        gradt_ceq = [];
    end
else
    gradt_c   = [];
    gradt_ceq = [];
end

%% gradients of process model \wrt to states (x)
if (~isempty(x))
    states         = struct('f',x,'dx',ones(length(x),1));
    [yx_c, yx_ceq] = param.gradx_confun(t, states, u, p, flag);

    % inequality constraintes 
    if (isfield(yx_c,'dx_size'))
        if (length(yx_c.dx_size) == 1)
            gradx_c = zeros(yx_c.dx_size,1);
            index_x = sub2ind(size(gradx_c), yx_c.dx_location,...
                              ones(length(yx_c.dx_location),1));
            gradx_c(index_x) = yx_c.dx;
            gradx_c          = gradx_c;
        else
            gradx_c   = zeros(yx_c.dx_size);
            index_x = sub2ind(yx_c.dx_size, yx_c.dx_location(:,1),...
                              yx_c.dx_location(:,2));
            gradx_c(index_x) = yx_c.dx;
            gradx_c          = gradx_c';
        end
    else
        gradx_c = [];
    end
    
    % equality constraintes :
    if (isfield(yx_ceq,'dx_size'))
        if (length(yx_ceq.dx_size) == 1)
            gradx_ceq = zeros(yx_ceq.dx_size,1);
            index_x   = sub2ind(size(gradx_ceq), yx_ceq.dx_location,...
                                ones(length(yx_ceq.dx_location),1));
            gradx_ceq(index_x) = yx_ceq.dx;
            gradx_ceq          = gradx_ceq;
        else
            gradx_ceq   = zeros(yx_ceq.dx_size);
            index_x = sub2ind(yx_ceq.dx_size, yx_ceq.dx_location(:,1),...
                              yx_ceq.dx_location(:,2));
            gradx_ceq(index_x) = yx_ceq.dx;
            gradx_ceq          = gradx_ceq';
        end
    else
        gradx_ceq = [];
    end
else
    gradx_c   = [];
    gradx_ceq = [];
end


%% gradients of process model \wrt to control (u)
if (~isempty(u))
    control        = struct('f',u,'du',ones(length(u),1));
    [yu_c, yu_ceq] = param.gradu_confun(t, x, control, p, flag);

    % inequality constraintes 
    if (isfield(yu_c,'du_size'))
        if (length(yu_c.du_size) == 1)
            gradu_c = zeros(yu_c.du_size,1);
            index_u = sub2ind(size(gradu_c), yu_c.du_location,...
                              ones(length(yu_c.du_location),1));
            gradu_c(index_u) = yu_c.du;            
            gradu_c          = gradu_c';
        else
            gradu_c   = zeros(yu_c.du_size);
            index_u = sub2ind(yu_c.du_size, yu_c.du_location(:,1),...
                              yu_c.du_location(:,2));
            gradu_c(index_u) = yu_c.du;
            gradu_c          = gradu_c';
        end
    else
        gradu_c = [];
    end
    
    % equality constraintes :
    if (isfield(yu_ceq,'du_size'))
        if (length(yu_ceq.du_size) == 1)
            gradu_ceq = zeros(yu_ceq.du_size,1);
            index_u   = sub2ind(size(gradu_ceq), yu_ceq.du_location,...
                                ones(length(yu_ceq.du_location),1));
            gradu_ceq(index_u) = yu_ceq.du;
            gradu_ceq          = gradu_ceq';
        else
            gradu_ceq   = zeros(yu_ceq.du_size);
            index_u = sub2ind(yu_ceq.du_size, yu_ceq.du_location(:,1),...
                              yu_ceq.du_location(:,2));
            gradu_ceq(index_u) = yu_ceq.du;
            gradu_ceq          = gradu_ceq';
        end
    else
        gradu_ceq = [];
    end
else
    gradu_c   = [];
    gradu_ceq = [];
end

%% gradients of process model \wrt to parameters (p)
if (~isempty(p))
    parameter        = struct('f',p,'dp',ones(length(p),1));
    [yp_c, yp_ceq] = param.gradp_confun(t, x, u, parameter, flag);

    % inequality constraintes 
    if (isfield(yp_c,'dp_size'))
        if (length(yp_c.dp_size) == 1)
            gradp_c = zeros(yp_c.dp_size,1);
            index_p = sub2ind(size(gradp_c), yp_c.dp_location,...
                              ones(length(yp_c.dp_location),1));
            gradp_c(index_p) = yp_c.dp;
            gradp_c          = gradp_c';
        else
            gradp_c   = zeros(yp_c.dp_size);
            index_p = sub2ind(yp_c.dp_size, yp_c.dp_location(:,1),...
                              yp_c.dp_location(:,2));
            gradp_c(index_p) = yp_c.dp;
            gradp_c          = gradp_c';
        end
    else
        gradp_c = [];
    end
    
    % equality constraintes :
    if (isfield(yp_ceq,'dp_size'))
        if (length(yp_ceq.dp_size) == 1)
            gradp_ceq = zeros(yp_ceq.dp_size,1);
            index_p   = sub2ind(size(gradp_ceq), yp_ceq.dp_location,...
                                ones(length(yp_ceq.dp_location),1));
            gradp_ceq(index_p) = yp_ceq.dp;
            gradp_ceq          = gradp_ceq';
        else
            gradp_ceq   = zeros(yp_ceq.dp_size);
            index_p = sub2ind(yp_ceq.dp_size, yp_ceq.dp_location(:,1),...
                              yp_ceq.dp_location(:,2));
            gradp_ceq(index_p) = yp_ceq.dp;
            gradp_ceq          = gradp_ceq';
        end
    else
        gradp_ceq = [];
    end
else
    gradp_c   = [];
    gradp_ceq = [];
end

%% checking the length of the constraintes :
c_len   = length(c);
ceq_len = length(ceq);

t_len   = length(t);
x_len   = length(x);
u_len   = length(u);
p_len   = length(p);

if (isempty(c) && isempty(ceq))
    % inequality constraints :
    JacT.c = [];
    JacX.c = [];
    JacU.c = [];
    JacP.c = [];
    % equality constraintes :
    JacT.ceq = [];
    JacX.ceq = [];
    JacU.ceq = [];
    JacP.ceq = [];
    
elseif(~isempty(c) && isempty(ceq))
    % inequality constraints :
        if (isempty(gradt_c))
            JacT.c = [];
        else
            JacT.c = gradt_c(1:t_len,1:c_len);
        end
        if (isempty(gradx_c))
            JacX.c = [];
        else
            JacX.c = gradx_c(1:x_len,1:c_len);
        end
        if (isempty(gradu_c))
            JacU.c = [];
        else
            JacU.c = gradu_c(1:u_len,1:c_len);
        end
        if (isempty(gradp_c))
            JacP.c = [];
        else
            JacP.c = gradp_c(1:p_len,1:c_len);
        end   
    % equality constraintes :
    JacT.ceq = [];
    JacX.ceq = [];
    JacU.ceq = [];
    JacP.ceq = [];
    
elseif(isempty(c) && ~isempty(ceq))
    % inequality constraints :
    JacT.c = [];
    JacX.c = [];
    JacU.c = [];
    JacP.c = [];
    % equality constraintes :
        if (isempty(gradt_ceq))
            JacT.ceq = [];
        else
            JacT.ceq = gradt_ceq(1:t_len,1:ceq_len);
        end
        if (isempty(gradx_ceq))
            JacX.ceq = [];
        else
            JacX.ceq = gradx_ceq(1:x_len,1:ceq_len);
        end
        if (isempty(gradu_ceq))
            JacU.ceq = [];
        else
            JacU.ceq = gradu_ceq(1:u_len,1:ceq_len);
        end
        if (isempty(gradp_ceq))
            JacP.ceq = [];
        else
            JacP.ceq = gradp_ceq(1:p_len,1:ceq_len);
        end   
elseif(~isempty(c) && ~isempty(ceq))
    % inequality constraints :
        if (isempty(gradt_c))
            JacT.c = [];
        else
            JacT.c = gradt_c(1:t_len,1:c_len);
        end
        if (isempty(gradx_c))
            JacX.c = [];
        else
            JacX.c = gradx_c(1:x_len,1:c_len);
        end
        if (isempty(gradu_c))
            JacU.c = [];
        else
            JacU.c = gradu_c(1:u_len,1:c_len);
        end
        if (isempty(gradp_c))
            JacP.c = [];
        else
            JacP.c = gradp_c(1:p_len,1:c_len);
        end   
    % equality constraintes :
        if (isempty(gradt_ceq))
            JacT.ceq = [];
        else
            JacT.ceq = gradt_ceq(1:t_len,1:ceq_len);
        end
        if (isempty(gradx_ceq))
            JacX.ceq = [];
        else
            JacX.ceq = gradx_ceq(1:x_len,1:ceq_len);
        end
        if (isempty(gradu_ceq))
            JacU.ceq = [];
        else
            JacU.ceq = gradu_ceq(1:u_len,1:ceq_len);
        end
        if (isempty(gradp_ceq))
            JacP.ceq = [];
        else
            JacP.ceq = gradp_ceq(1:p_len,1:ceq_len);  
        end
end