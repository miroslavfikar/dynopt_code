format long e;
t = 0.9150678387143234004952319082804024219512939453125000000;
x = [-0.2183184917817383163818334423922351561486721038818359375 -0.0116759353998009789143974757053001667372882366180419922 1.3341244188652952029627840602188371121883392333984375000 0.1218614636390677047339536898107326123863458633422851562];
u = 5.7493134564287844412433514662552624940872192382812500000;

p = [];
flag = 2;
[~,~,JacU,~] = dgrad_process(t,x,flag,u,p)
JacU_orig = processd(t,x,flag,u,p)


