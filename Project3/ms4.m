function [T,X,ind] = ms4(f,t0,tf,h,x0)
% ADAMS-FOURTH ORDER PREDICTOR-CORRECTOR ALGORITHM 5.4
% 
% INPUT:   f,t0,tf,h,x0
%
% OUTPUT:  T: time, X: x
%

% STEP 1
N = floor((tf-t0)/h);
T = zeros(1,N+1);
X = zeros(length(x0),N+1);

T(1) = t0;
X(:,1) = x0;
% STEP 2
for I = 1:3
    % STEP 3 AND 4
    % compute starting values using Runge-Kutta method
    T(I+1) = T(I)+h;
    K1 = h*f(T(I), X(:,I));
    K2 = h*f(T(I)+0.5*h, X(:,I)+0.5*K1);
    K3 = h*f(T(I)+0.5*h, X(:,I)+0.5*K2);
    K4 = h*f(T(I+1), X(:,I)+K3);
    X(:,I+1) = X(:,I)+(K1+2.0*(K2+K3)+K4)/6.0;
    % STEP 5
end
% STEP 6
for I = 4:N    % STEP 7    
    T(I+1) = T(I)+h;    
    % predict X(I+1)
    Part1 = 55.0*f(T(I),X(:,I))-59.0*f(T(I-1),X(:,I-1))+37.0*f(T(I-2),X(:,I-2));
    Part2 = -9.0*f(T(I-3),X(:,I-3));
    X0 = X(:,I)+h*(Part1+Part2)/24.0;
    
    % correct X(I+1)
    Part1 = 9.0*f(T(I+1),X0)+19.0*f(T(I),X(:,I))-5.0*f(T(I-1),X(:,I-1))+f(T(I-2),X(:,I-2));
    X(:,I+1) = X(:,I)+h*(Part1)/24.0;
    
    if abs(X(1,I+1) -5*pi)<1e-3
        break
    end
    
end
ind = I+1;