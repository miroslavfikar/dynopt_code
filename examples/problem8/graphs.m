load optimprofiles tplot uplot xplot
tm = [1;2;3;5]; 
xm = [0.264 0.594 0.801 0.958;
      NaN NaN NaN NaN]; 

% ploting
%..........................................................................
plot(tm,xm(1,:)','k*',tplot,xplot(:,1),'r-')
title('')
xlabel('time')
ylabel('x_1')
legend('x_{1,measured}','x_{1,estimated}',4)
axis tight
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

print -depsc x.eps
pause
close
%..........................................................................