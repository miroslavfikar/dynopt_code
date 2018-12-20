load optimprofiles tplot uplot xplot

% ploting
%..........................................................................
plot(tplot,uplot,'k')
title('')
xlabel('time')
ylabel('\alpha')
v=axis;
axis([v(1) v(2) -0.003 1.003])
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])
print -depsc2 control.eps
pause

plot(tplot,xplot(:,1),'b:',tplot,xplot(:,2),'r--')
title('')
xlabel('time')
ylabel('x_1, x_2')
legend('x_1','x_2','Location','NorthEast')
axis tight 
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])
print -depsc2 x12.eps
pause

plot(tplot,xplot(:,3),'k-')
title('')
xlabel('time')
ylabel('x_3')
v=axis;
axis([v(1) v(2) 0.0098 v(4)])
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])
print -depsc2 x3.eps

pause

close
%..........................................................................