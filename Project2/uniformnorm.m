function c=uniformnorm(f,a,b)
% c=uniformnorm(f,a,b)
% uniformnorm ||f||_inf = max(abs(f)) on interval [a,b]
% call findlocalextreme to find the local extreme, then compare with the 
% boundary value to determine the uniformnorm
%
x0 = (f(a)+f(b))/2;           % initial guess of the local extreme at the middle of the interval
[x,y]=findlocalextreme(f,x0); % find local extreme 
c = max(abs([f(a),f(b),y]));  % get the uniform norm