function [x,y] = findlocalextreme(f,x0)
%
% find the local extreme near x0 without approximate derivative 
% by calling findroot to find the root of approximated derivative
%
h = 1e-4;  % step size for approximate the derivative
df = @(x) (f(x+h)-f(x))/(2*h); % approximate the derivative by central difference
x = findroot(df,x0);           % call findroot to locate the locale extreme
y = f(x);
