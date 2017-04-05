%% main function for generating gradients using ADIgator
function adigator_gradients(t_len,x_len,u_len,p_len)

derivatives_process ( t_len, x_len, u_len, p_len )
derivatives_objfun  ( t_len, x_len, u_len, p_len )
derivatives_confun  ( t_len, x_len, u_len, p_len )

end

%% process model :
function derivatives_process(t_len, x_len, u_len, p_len)
options = adigatorOptions('overwrite',1,... 
                          'echo',0,...
                          'comments',0);
                      
% adigator gradients -- process model (time)
t = adigatorCreateDerivInput([t_len 1], 't');
x = adigatorCreateAuxInput([x_len 1]);
u = adigatorCreateAuxInput([u_len 1]);
p = adigatorCreateAuxInput([p_len 1]);
flag = adigatorCreateAuxInput([1 1]);
adigator('process', {t, x, u, p, flag}, 'gradt_process', options);
                    
% adigator gradients -- process model (states)
x = adigatorCreateDerivInput([x_len 1],'x');
u = adigatorCreateAuxInput([u_len 1]);
p = adigatorCreateAuxInput([p_len 1]);
t = adigatorCreateAuxInput([t_len 1]);
flag = adigatorCreateAuxInput([1 1]);
adigator('process', {t, x, u, p, flag}, 'gradx_process', options);

% adigator gradients -- process model (control)
u = adigatorCreateDerivInput([u_len 1], 'u');
x = adigatorCreateAuxInput([x_len 1]);
p = adigatorCreateAuxInput([p_len 1]);
t = adigatorCreateAuxInput([t_len 1]);
flag = adigatorCreateAuxInput([1 1]);
adigator('process', {t, x, u, p, flag}, 'gradu_process', options);

% adigator gradients -- process model (parameters)
p = adigatorCreateDerivInput([p_len 1], 'p');
x = adigatorCreateAuxInput([x_len 1]);
u = adigatorCreateAuxInput([u_len 1]);
t = adigatorCreateAuxInput([t_len 1]);
flag = adigatorCreateAuxInput([1 1]);
adigator('process', {t, x, u, p, flag}, 'gradp_process', options);
end

%% objective function
function derivatives_objfun(t_len, x_len, u_len, p_len)
% adigator options :
options = adigatorOptions('overwrite',1,... 
                          'echo',0,...
                          'comments',0);
                      
% adigator gradients -- process model (time)
t = adigatorCreateDerivInput([t_len 1], 't');
x = adigatorCreateAuxInput([x_len 1]);
u = adigatorCreateAuxInput([u_len 1]);
p = adigatorCreateAuxInput([p_len 1]);
adigator('objfun', {t, x, u, p}, 'gradt_objfun', options);
                    
% adigator gradients -- process model (states)
x = adigatorCreateDerivInput([x_len 1],'x');
u = adigatorCreateAuxInput([u_len 1]);
p = adigatorCreateAuxInput([p_len 1]);
t = adigatorCreateAuxInput([t_len 1]);
adigator('objfun', {t, x, u, p}, 'gradx_objfun', options);

% adigator gradients -- process model (control)
u = adigatorCreateDerivInput([u_len 1], 'u');
x = adigatorCreateAuxInput([x_len 1]);
p = adigatorCreateAuxInput([p_len 1]);
t = adigatorCreateAuxInput([t_len 1]);
adigator('objfun', {t, x, u, p}, 'gradu_objfun', options);

% adigator gradients -- process model (parameters)
p = adigatorCreateDerivInput([p_len 1], 'p');
x = adigatorCreateAuxInput([x_len 1]);
u = adigatorCreateAuxInput([u_len 1]);
t = adigatorCreateAuxInput([t_len 1]);
adigator('objfun', {t, x, u, p}, 'gradp_objfun', options);
end

%% constraints -- nonlinear 
function derivatives_confun(t_len, x_len, u_len, p_len)
% adigator options :
options = adigatorOptions('overwrite',1,... 
                          'echo',0,...
                          'comments',0);
                      
% adigator gradients -- process model (time)
t = adigatorCreateDerivInput([t_len 1], 't');
x = adigatorCreateAuxInput([x_len 1]);
u = adigatorCreateAuxInput([u_len 1]);
p = adigatorCreateAuxInput([p_len 1]);
flag = adigatorCreateAuxInput([1 1]);
adigator('confun', {t, x, u, p, flag}, 'gradt_confun', options);
                    
% adigator gradients -- process model (states)
x = adigatorCreateDerivInput([x_len 1],'x');
u = adigatorCreateAuxInput([u_len 1]);
p = adigatorCreateAuxInput([p_len 1]);
t = adigatorCreateAuxInput([t_len 1]);
flag = adigatorCreateAuxInput([1 1]);
adigator('confun', {t, x, u, p, flag}, 'gradx_confun', options);

% adigator gradients -- process model (control)
u = adigatorCreateDerivInput([u_len 1], 'u');
x = adigatorCreateAuxInput([x_len 1]);
p = adigatorCreateAuxInput([p_len 1]);
t = adigatorCreateAuxInput([t_len 1]);
flag = adigatorCreateAuxInput([1 1]);
adigator('confun', {t, x, u, p, flag}, 'gradu_confun', options);

% adigator gradients -- process model (parameters)
p = adigatorCreateDerivInput([p_len 1], 'p');
x = adigatorCreateAuxInput([x_len 1]);
u = adigatorCreateAuxInput([u_len 1]);
t = adigatorCreateAuxInput([t_len 1]);
flag = adigatorCreateAuxInput([1 1]);
adigator('confun', {t, x, u, p, flag}, 'gradp_confun', options);
end