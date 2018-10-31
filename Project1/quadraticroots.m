function [r1,r2] = quadraticroots(a,b,c)
% p(t) = a*x^2 + b*x + c
% define function handles
% We want extrema of f
p = @(t)a.*t.^2 + b.*t + c;
% Use Newton to solve f'(x) = 0 to find critical points
dp = @(t)2.*a.*t + b; 

delta=sqrt(b^2-4*a*c);
x1=(-b+delta)/(2*a);
x2=(-b-delta)/(2*a);

r1 = findroot(p,dp,x1);
r2 = findroot(p,dp,x2);