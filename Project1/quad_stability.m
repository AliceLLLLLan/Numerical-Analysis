% p(t) = a*x^2 + b*x + c
% define function handles
c=0.01;
b=1000;
a=0.01;
 
p = @(t)a.*t.^2 + b.*t + c;
% Use Newton to solve f'(x) = 0 to find critical points
dp = @(t)2.*a.*t + b; 
coeff = [a b c];
%(1)
R=roots(coeff);
%(2)
%call function in (a) directly
[r1,r2] = quadraticroots(a,b,c);
%(3)
delta=sqrt(b^2-4*a*c);
x1=(-b+delta)/(2*a); 
x2=(-b-delta)/(2*a);
% x1 > x2

%ea = the absolute error
%xm = the measured value x1 x2
%xt = the true value R(1) R(2)
%The formula for computing absolute error is: ea = | xm - xt |
if R(1)>R(2)
   ea1 = abs(R(1)-x1);
   ea2 = abs(R(2)-x2);
else %R(1)<=R(2)
   ea1 = abs(R(2)-x1);
   ea2 = abs(R(1)-x2);
end
EA = [ea1 ea2];
fprintf('(quatratic formula) The absolute errors are:');
disp(EA);
%er = the relative error
%The formula for computing relative error is: er = ( xm - xt )/xt
if R(1)>R(2)
   ea1 = abs(x1-R(1))/R(1);
   ea2 = abs(x2-R(2))/R(2);
else %R(1)<=R(2)
   ea1 = abs(x1-R(2))/R(2);
   ea2 = abs(x2-R(1))/R(1);
end
ER = [ea1 ea2];
fprintf('(quatratic formula) The relative errors are:');
disp(ER);


if R(1)>R(2)
   ea1 = abs(R(1)-r1);
   ea2 = abs(R(2)-r2);
else %R(1)<=R(2)
   ea1 = abs(R(2)-r1);
   ea2 = abs(R(1)-r2);
end
EA = [ea1 ea2];
fprintf('(quatraticroots) The absolute errors are:');
disp(EA);
%er = the relative error
%The formula for computing relative error is: er = ( xm - xt )/xt
if R(1)>R(2)
   ea1 = abs(r1-R(1))/R(1);
   ea2 = abs(r2-R(2))/R(2);
else %R(1)<=R(2)
   ea1 = abs(r1-R(2))/R(2);
   ea2 = abs(r2-R(1))/R(1);
end
ER = [ea1 ea2];
fprintf('(quatraticroots) The relative errors are:');
disp(ER);
