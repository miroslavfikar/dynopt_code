load optimprofiles tplot uplot xplot tp cp ceqp

% ploting
%..........................................................................
plot(tplot,uplot,'k')
title('')
xlabel('time')
ylabel('u')
axis tight 
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

print -depsc u.eps
pause

plot(tplot,xplot(:,1),'b:',tplot,xplot(:,2),'r--',tplot,xplot(:,3),'k-')
title('')
xlabel('time')
ylabel('x_1, x_2, x_3')
legend('x_1','x_2','x_3','Location','southeast')
axis tight 
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

print -depsc x.eps
pause

plot(tp,cp,'k-',[0;1],[0;0],'r:')
title('')
xlabel('time')
ylabel('c')
axis([0 1 -2.5 0.5]) 
set(1,'PaperUnits','centimeters')
set(1,'PaperPosition',[3 10 11 8.25])

print -depsc c.eps
pause
close
%..........................................................................