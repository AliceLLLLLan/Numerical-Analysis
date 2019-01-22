function [t,y] = rk4(f,t0,tf,h,y0)
%
% ode integration method: 4th-order runge-kutta method
% Input:
%   f: ode funciton
%   t0,tf: time interval endpoints
%   h:  ode integration stepsize
%   y0: initial condition
% Output:
%   t: time vector
%   y: integration result
% If f is an M-file function, call [t,y]=rk4(@f,a,b,ya,M)
% If f is an anonymous function, call [t,y]=rk4(f,a,b,ya,M)

n = floor((tf-t0)/h); % number of steps
t = t0:h:tf;          % time vector
y(:,1) = y0(:);       % initial vector
for i = 1:n           
    k1 = f(t(i),y(:,i));
    k2 = f(t(i)+h/2 , y(:,i)+h*k1/2);
    k3 = f(t(i)+h/2 , y(:,i)+h*k2/2);
    k4 = f(t(i)+h, y(:,i)+h*k3);
    y(:,i+1) = y(:,i)+h*(k1+2*k2+2*k3+k4)/6;
end
