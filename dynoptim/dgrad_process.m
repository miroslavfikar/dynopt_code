function Jac = dgrad_process( t, x, flag, u, p, param )

% gradients of process model \wrt to states (x)
  if flag==1
    if (~isempty(x))
      origflag = 0;
      states  = struct('f',x,'dx',ones(length(x),1));
      y_x     = param.gradx_process(t, states, origflag, u, p);
      
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
    Jac = gradx';
  end    

  % gradients of process model \wrt to control (u)
  if flag==2
    if (~isempty(u))
      origflag = 0;
      control = struct('f',u,'du',ones(length(u),1));
      y_u     = param.gradu_process(t, x, origflag, control, p);
      
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
    Jac = gradu';
  end

  % gradients of process model \wrt to parameters (p)
  if flag==3 | flag==6

    if flag == 6
      origflag = 5;
    else
      origflag = 0;
    end
    
    if (~isempty(p))
      parameter = struct('f',p,'dp',ones(length(p),1));
      y_p     = param.gradp_process(t, x, origflag, u, parameter);
      
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
    Jac = gradp';
  end

% gradients of process model \wrt to time (t)
  if flag==4
    if (~isempty(t))
      origflag = 0;
      t_time = struct('f',t,'dt',ones(length(t),1));
      y_t    = param.gradt_process(t_time, x, origflag, u, p);
      
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
    Jac = gradt';
  end
