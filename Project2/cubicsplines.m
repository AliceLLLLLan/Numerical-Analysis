function C = cubicsplines(x,y,b)
%
% Use piecewise cubic splines to interprete the data x and y
% with the assigned boundary condition b
%
n = length(x);  % length of x
A = zeros(n,n); r = zeros(n,1);
dx = diff(x);   dy = diff(y);
for i = 2:n-1 
    A(i, i-1:i+1) = [dx(i-1) 2*(dx(i-1)+dx(i)) dx(i)];
    r(i) = 3*(dy(i)/dx(i)-dy(i-1)/dx(i-1)); % right-hand side
end
% Set boundary conditions
A(1,1)= 2;
A(n,n)= 2;
r(1)  = b(1);
r(n)  = b(2);
c = zeros(n,3);
c(:,2)= A\r; % solve for c_i_2 coefficients
% from c_i_3, sovle c_i_1 and c_i_3
for i=1:n-1
    c(i,3) = (c(i+1,2)-c(i,2))/(3*dx(i));
    c(i,1) = dy(i)/dx(i)-dx(i)*(2*c(i,2)+c(i+1,2))/3;
end
c = c(1:n-1,1:3);
C = zeros(n-1,4);
% Transform from the local coefficient to global coefficient
for ii = 1:n-1
    t4 = c(ii,3)*poly(x(ii));
    t3 = conv(poly(x(ii)),[0 c(ii,2)]+t4);
    t2 = conv(poly(x(ii)),[0 0 c(ii,1)] + t3);
    C(ii,:) = [0 0 0 y(ii)]+ t2;
end

C = fliplr(C); % make the arrange of Coefficient meet the Assignment's order