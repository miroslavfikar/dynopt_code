function sys = processd(t,x,flag,u,p)

  sys = [];
  if flag == 1 % df/dx
    sys = [0 2*x(1);0 0];
  elseif flag == 2 % df/du
    sys = [1 2*u];
  end
end