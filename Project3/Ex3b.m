clc
clear
close all
%% b
t0 = 0;
tf = 40;
h = 0.01;
x0 = [5*pi/4 sqrt(2-sqrt(2))]';
r = 0;
f = @(t,x) [x(2);-r*x(2)-sin(x(1))];
[T,X] = ms4(f,t0,tf,h,x0);
[T1,Y1] = ode45(f,[0 tf],x0);
figure('position',[300 200 600 300]);
plot(T,X(1,:),'k-')
hold on
plot(T1,Y1(:,1),'b-')
title(sprintf('h=%3.3f',h))
xlim([0 40])
xlabel('\theta'),ylabel('d\theta')
legend('ms4','ode45','Location','best')
set(gca,'FontSize',12)
set(gcf, 'PaperPosition', [0.2 0.2 14 6.8]);
set(gcf, 'PaperSize', [14 7]);
saveas(gcf, 'h=21.pdf');
%
h = 0.001;
x0 = [5*pi/4 sqrt(2-sqrt(2))]';
r = 0;
f = @(t,x) [x(2);-r*x(2)-sin(x(1))];
[T,X] = ms4(f,t0,tf,h,x0);
[T1,Y1] = ode45(f,[0 tf],x0);
figure('position',[400 200 600 300]);
plot(T,X(1,:),'k-')
hold on
plot(T1,Y1(:,1),'b-')
title(sprintf('h=%3.3f',h))
set(gca,'FontSize',12)
xlabel('\theta'),ylabel('d\theta')
legend('ms4','ode45','Location','best')
xlim([0 40])
set(gcf, 'PaperPosition', [0.2 0.2 14 6.8]);
set(gcf, 'PaperSize', [14 7]);
saveas(gcf, 'h=22.pdf');

