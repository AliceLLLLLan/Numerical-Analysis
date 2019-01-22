%% code for 1.
clc
clear
%% (a) update the findroot function 
f = @(x) 0.5-sin(x);
df = @(x) -cos(x);
x0 = 1;  % initial guess for the root
x1 = findroot(f,x0)    % the updated function without derivative
x2 = findroot(f,df,x0) % compare with the case with derivative
%% (b) find the local extreme around x0
f = @(x) 0.5-sin(x);
x0 = 1; % initial guess for the local extreme
localextreme = findlocalextreme(f,x0)

%% (c) find the uniformnorm on [a,b]
f = @(x) 0.5-sin(x);
a = -1;
b = 1;
unorm = uniformnorm(f,a,b)