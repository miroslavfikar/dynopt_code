load optimprofiles tplot uplot xplot

% ploting
%..........................................................................
plot(tplot,uplot,'k')
title('')
xlabel('time')
ylabel('u')
set(gcf,'PaperUnits','centimeters')
set(gcf,'PaperPosition',[3 10 11 8.25])
aa=axis;
axis([aa(1:2) aa(3)-0.1 aa(4)+0.1])
print -depsc car_u.eps


figure
plot(tplot,xplot(:,1),'k-')
title('')
xlabel('time')
ylabel('x_1')
set(gcf,'PaperUnits','centimeters')
set(gcf,'PaperPosition',[3 10 11 8.25])
print -depsc car_x1.eps

figure
plot(tplot,xplot(:,2),'k-')
title('')
xlabel('time')
ylabel('x_2')
set(gcf,'PaperUnits','centimeters')
set(gcf,'PaperPosition',[3 10 11 8.25])
print -depsc car_x2.eps
%..........................................................................