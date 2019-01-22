clc
clear
close all
%% case 1: initial points chosen randomly on the unit sphere
% 
rng(2018) %  random number generation seed 2018
f = @(t,y) [10*(y(2)-y(1));28*y(1)-y(2)-y(1)*y(3); y(1)*y(2)-8/3*y(3)]; % ode function
h = 0.01; % step size
y01 = -1+ 2* rand(3,1); 
t0 = 0;
tf = 5;   % integration time units
[t1,y1] = rk4(f,t0,tf,h,y01);

figure
plot3(y1(1,:),y1(2,:),y1(3,:),'k-')
set(gca,'FontSize',12,'Fontname', 'Euclid')
xlabel('x')
ylabel('y')
zlabel('z')
title('Trajectory of initial points from unit sphere')

%% case 2: initial point chosen randomly on a sphere of radius 2
% 
f = @(t,y) [10*(y(2)-y(1));28*y(1)-y(2)-y(1)*y(3); y(1)*y(2)-8/3*y(3)]; % ode function
y02 =-2+ 4* rand(3,1); % initial condition random points on sphere with radius 2
t0 = 0;                % beginning integration time
tf = 5;                % integration time units
h  = 0.01;             % step size
[t2,y2] = rk4(f,t0,tf,h,y02);

figure
plot3(y2(1,:),y2(2,:),y2(3,:),'k-')
set(gca,'FontSize',12,'Fontname', 'Euclid')
xlabel('x')
ylabel('y')
zlabel('z')
title('Trajectory of initial point from radius 2 sphere')
