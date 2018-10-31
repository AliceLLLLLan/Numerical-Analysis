function [] = expsolver(x)
%by using T1 = taylor(F, x, 'Order', 10);, we could get the 10th order
%Taylor approximation.
P= @(x)x.^9./362880 + x.^8./40320 + x.^7./5040 + x.^6./720 + x.^5./120 + x.^4./24 + x.^3./6 + x.^2./2 + x + 1;
T = P(x);
fprintf('10th order Taylor approximation is:');
disp(T);

R=exp(x);
fprintf('exp is:');
disp(R);

D= T-R; 
fprintf('The difference is:');
disp(D);

