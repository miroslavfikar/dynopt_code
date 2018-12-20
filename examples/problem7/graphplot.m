load optimprofiles tplot uplot xplot

% ploting
%..........................................................................
plot(tplot,uplot(:,1),'k-')
title('')
xlabel('time')
ylabel('u_1')
axis tight
% axis([0 30 -2.05 1.05])
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

print -depsc u1.eps
pause

plot(tplot,uplot(:,2),'k-')
title('')
xlabel('time')
ylabel('u_2')
axis tight
% axis([0 30 -2.05 1.05])
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

print -depsc u2.eps
pause

plot(tplot,uplot(:,3),'k-')
title('')
xlabel('time')
ylabel('u_3')
axis tight
% axis([0 30 -2.05 1.05])
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

print -depsc u3.eps
pause

plot(tplot,uplot(:,4),'k-')
title('')
xlabel('time')
ylabel('u_4')
axis tight
% axis([0 30 -2.05 1.05])
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

print -depsc u4.eps
pause

plot(tplot,xplot(:,1),'k-',tplot,xplot(:,2),'b-',tplot,xplot(:,3),'r-', ...
     tplot,xplot(:,4),'g-',tplot,xplot(:,5),'c-',tplot,xplot(:,6),'y-', ...
     tplot,xplot(:,7),'m-')
title('')
xlabel('time')
ylabel('x_1, x_2, x_3, x_4, x_5, x_6, x_7')
legend('x_1','x_2','x_3','x_4','x_5','x_6','x_7','Location','NorthEast')
axis tight
% axis([0 30 0 20.05])
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

print -depsc x17.eps
pause

plot(tplot,xplot(:,8),'k-')
title('')
xlabel('time')
ylabel('x_8')
axis tight
% axis([0 30 0 20.05])
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

print -depsc x8.eps
pause
close
%..........................................................................