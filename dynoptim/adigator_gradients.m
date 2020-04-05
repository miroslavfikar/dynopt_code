%% main function for generating gradients using ADIgator
function adigator_gradients(param)
  options = adigatorOptions('overwrite',1,... 
			    'echo',0,...
			    'comments',0);
  if ~param.adoptions.processjacuser
    process = func2str(param.origprocess);
    gradt_process = strcat('grad','t','_',process);
    gradx_process = strcat('grad','x','_',process);
    gradu_process = strcat('grad','u','_',process);
    gradp_process = strcat('grad','p','_',process);
  
    % adigator gradients -- process model (time)
    t = adigatorCreateDerivInput([1 1], 't');
    x = adigatorCreateAuxInput([param.nx 1]);
    u = adigatorCreateAuxInput([param.nu 1]);
    p = adigatorCreateAuxInput([param.np 1]);
    flag = adigatorCreateAuxInput([1 1]);
    adigator(process, {t, x, u, p, flag}, gradt_process, options);
    
    % adigator gradients -- process model (states)
    x = adigatorCreateDerivInput([param.nx 1],'x');
    u = adigatorCreateAuxInput([param.nu 1]);
    p = adigatorCreateAuxInput([param.np 1]);
    t = adigatorCreateAuxInput([1 1]);
    flag = adigatorCreateAuxInput([1 1]);
    adigator(process, {t, x, u, p, flag}, gradx_process, options);
    
    % adigator gradients -- process model (control)
    u = adigatorCreateDerivInput([param.nu 1], 'u');
    x = adigatorCreateAuxInput([param.nx 1]);
    p = adigatorCreateAuxInput([param.np 1]);
    t = adigatorCreateAuxInput([1 1]);
    flag = adigatorCreateAuxInput([1 1]);
    adigator(process, {t, x, u, p, flag}, gradu_process, options);
    
    % adigator gradients -- process model (parameters)
    p = adigatorCreateDerivInput([param.np 1], 'p');
    x = adigatorCreateAuxInput([param.nx 1]);
    u = adigatorCreateAuxInput([param.nu 1]);
    t = adigatorCreateAuxInput([1 1]);
    flag = adigatorCreateAuxInput([1 1]);
    adigator(process, {t, x, u, p, flag}, gradp_process, options);
  end
  
  if ~param.adoptions.objfunjacuser
    objfun = func2str(param.origobjfun);
    gradt_objfun = strcat('grad','t','_',objfun); 
    gradx_objfun = strcat('grad','x','_',objfun); 
    gradu_objfun = strcat('grad','u','_',objfun); 
    gradp_objfun = strcat('grad','p','_',objfun); 

    if isempty(param.objtype) % objfun: Meyer
    else % objfun: Sum
      xm = adigatorCreateAuxInput([param.nx 1]);
    end

    % adigator gradients -- objfun (time)
    t = adigatorCreateDerivInput([1 1], 't');
    x = adigatorCreateAuxInput([param.nx 1]);
    u = adigatorCreateAuxInput([param.nu 1]);
    p = adigatorCreateAuxInput([param.np 1]);
    if isempty(param.objtype) % objfun: Meyer
      adigator(objfun, {t, x, u, p}, gradt_objfun, options);
    else % objfun: Sum
      adigator(objfun, {t, x, u, p, xm}, gradt_objfun, options);
    end
    
    % adigator gradients -- objfun (states)
    x = adigatorCreateDerivInput([param.nx 1],'x');
    u = adigatorCreateAuxInput([param.nu 1]);
    p = adigatorCreateAuxInput([param.np 1]);
    t = adigatorCreateAuxInput([1 1]);
    if isempty(param.objtype) % objfun: Meyer
      adigator(objfun, {t, x, u, p}, gradx_objfun, options);
    else % objfun: Sum
      adigator(objfun, {t, x, u, p, xm}, gradx_objfun, options);
    end

    % adigator gradients -- objfun (control)
    u = adigatorCreateDerivInput([param.nu 1], 'u');
    x = adigatorCreateAuxInput([param.nx 1]);
    p = adigatorCreateAuxInput([param.np 1]);
    t = adigatorCreateAuxInput([1 1]);
    if isempty(param.objtype) % objfun: Meyer
      adigator(objfun, {t, x, u, p}, gradu_objfun, options);
    else % objfun: Sum
      adigator(objfun, {t, x, u, p, xm}, gradu_objfun, options);
    end

    % adigator gradients -- objfun (parameters)
    p = adigatorCreateDerivInput([param.np 1], 'p');
    x = adigatorCreateAuxInput([param.nx 1]);
    u = adigatorCreateAuxInput([param.nu 1]);
    t = adigatorCreateAuxInput([1 1]);
    if isempty(param.objtype) % objfun: Meyer
      adigator(objfun, {t, x, u, p}, gradp_objfun, options);
    else % objfun: Sum
      adigator(objfun, {t, x, u, p, xm}, gradp_objfun, options);
    end
  end
  
  if ~isempty(param.confun) && ~param.adoptions.confunjacuser
    %% constraints -- nonlinear 
    confun = func2str(param.origconfun);
    gradt_confun = strcat('grad','t','_',confun); 
    gradx_confun = strcat('grad','x','_',confun);
    gradu_confun = strcat('grad','u','_',confun);
    gradp_confun = strcat('grad','p','_',confun);
    
    % adigator gradients -- confun (time)
    t = adigatorCreateDerivInput([1 1], 't');
    x = adigatorCreateAuxInput([param.nx 1]);
    u = adigatorCreateAuxInput([param.nu 1]);
    p = adigatorCreateAuxInput([param.np 1]);
    flag = adigatorCreateAuxInput([1 1]);
    adigator(confun, {t, x, u, p, flag}, gradt_confun, options);
    
    % adigator gradients -- confun (states)
    x = adigatorCreateDerivInput([param.nx 1],'x');
    u = adigatorCreateAuxInput([param.nu 1]);
    p = adigatorCreateAuxInput([param.np 1]);
    t = adigatorCreateAuxInput([1 1]);
    flag = adigatorCreateAuxInput([1 1]);
    adigator(confun, {t, x, u, p, flag}, gradx_confun, options);

    % adigator gradients -- confun (control)
    u = adigatorCreateDerivInput([param.nu 1], 'u');
    x = adigatorCreateAuxInput([param.nx 1]);
    p = adigatorCreateAuxInput([param.np 1]);
    t = adigatorCreateAuxInput([1 1]);
    flag = adigatorCreateAuxInput([1 1]);
    adigator(confun, {t, x, u, p, flag}, gradu_confun, options);

    % adigator gradients -- confun (parameters)
    p = adigatorCreateDerivInput([param.np 1], 'p');
    x = adigatorCreateAuxInput([param.nx 1]);
    u = adigatorCreateAuxInput([param.nu 1]);
    t = adigatorCreateAuxInput([1 1]);
    flag = adigatorCreateAuxInput([1 1]);
    adigator(confun, {t, x, u, p, flag}, gradp_confun, options);
  end