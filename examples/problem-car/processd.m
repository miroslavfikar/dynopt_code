function sys = processd(t,x,flag,u,p)

  if flag == 1 % df/dx
    sys = [0 1;0 0];
  elseif flag == 2 % df/du
    sys = [1 0];
  else
    sys = [];
  end
end