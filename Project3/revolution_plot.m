clc
clear
%%
x = 0.1;
r = 0.0;
rmax1 = fsolve(@(r) g(r,x),0.0);
% plot results
h = 0.001;
x0 = [pi x]';
t0 = 0;
tf = 40;
f = @(t,x) [x(2);-rmax1*x(2)-sin(x(1))];
[T,X] = ms4(f,t0,tf,h,x0);
%
figure('position',[300 200 600 300]);
plot(X(1,:),X(2,:),'k-')
title(sprintf('rmax=%3.3f',rmax1))
set(gca,'FontSize',12)
xlabel('\theta'),ylabel('d\theta')
set(gcf, 'PaperPosition', [0.2 0.2 14 6.8]);
set(gcf, 'PaperSize', [14 7]);
saveas(gcf, 'r=21.pdf');

%%
x = 0.3;
r = 0; % inital guess
rmax2 = fsolve(@(r) g(r,x),r); 
h = 0.001;
x0 = [pi x]';
t0 = 0;
tf = 40;
f = @(t,x) [x(2);-rmax2*x(2)-sin(x(1))];
[T,X] = ms4(f,t0,tf,h,x0);

figure('position',[400 200 600 300]);
plot(X(1,:),X(2,:),'k-')
title(sprintf('rmax=%3.3f',rmax2))
set(gca,'FontSize',12)
xlabel('\theta'),ylabel('d\theta')
set(gcf, 'PaperPosition', [0.2 0.2 14 6.8]);
set(gcf, 'PaperSize', [14 7]);
saveas(gcf, 'r=22.pdf');
