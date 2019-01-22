function Section2d
%
% Calculate the Spline Sn and n-polynomial pn interpolation and infinity norm
% pn is interpolated by Newton
%
b = [0 0]; % natural spline boundary condition
N = 2:15;  % division N vector
f = @(x) 1./(1+25.*x.^2); % interpolatary function
Smooth = zeros(N,2);      % preallocate the smooth and error storage
ErrorNorm = zeros(N,2);
for i = 1:length(N)
    n = N(i);
    x0 = -1; x1 = 1;      % data interval
    x  = linspace(x0,x1,n+1); y = f(x); % original data
    Cs = cubicsplines(x,y,b); % coefficient of spline interpolation
    Cp = newtonp(x,y);        % coefficient of pn interpolation
    % interpolate data from the obtained spline 
    X = []; % interpolatory data
    k = 10;  % each interpolatory interval has k inner points
    Sn = [];% interpolatory of spline
    mS = 0; % soomothness of spline
    for j = 1:n
        mS = mS + integral(@(x) (2*Cs(j,2)+3*Cs(j,3).*x).^2,x(j),x(j+1));
        xj = linspace(x(j),x(j+1),k+1);
        if j~=n
            X = [X xj(1:k)];
            Sn = [Sn polyval(fliplr(Cs(j,:)),xj(1:k))];
        else
            X = [X xj(1:k+1)];
            Sn = [Sn polyval(fliplr(Cs(j,:)),xj(1:k+1))];
        end
    end
    %
    % Since the build-in function cannot handle this integation,
    % adaptive Simpson's method is implemented
    %
    pvec = 3:(n+1); % after 2nd derivative, the index starts from 3 for the 
                    % smooth polynomial of the pn
    mP = adapSimpson(@(x) (sum(Cp(pvec).*(pvec-1).*(pvec-2).*x.^(pvec-3))).^2,x0,x1); 
    pn = polyval(fliplr(Cp),X); % evaluate the pn polynomial on X
    Smooth(1,i) = mS;
    Smooth(2,i) = mP;
    ErrorNorm(1,i) = norm(Sn-f(X),inf);
    ErrorNorm(2,i) = norm(pn-f(X),inf);
end
% plot with format
figure
hold on
plot(N,Smooth(1,:),'r-','linewidth',2)
plot(N,Smooth(2,:),'b-','linewidth',2)
set(gca,'FontSize',12,'Fontname', 'Euclid')
title('Smoothness of interpolation comparison')
legend('S_n','p_n','Location','northwest')
xlabel('$$N$$','interpreter','latex')
ylabel('Smoothness')
% plot with format
figure
hold on
plot(N,ErrorNorm(1,:),'r-','linewidth',2)
plot(N,ErrorNorm(2,:),'b-','linewidth',2)
set(gca,'FontSize',12,'Fontname', 'Euclid')
title('Infinity norm of the interpolatory error')
legend('S_n','p_n','Location','northwest')
xlabel('$$N$$','interpreter','latex')
ylabel('Error norm')

function S=adapSimpson(f,a,b)
% adaptive Simpson integration method
% f: integrand
% a,b: integration interval
% f = @(x) sin(x); a = 0; b = 1; s=adapSimpson(f,a,b)
tol = 1e-6;
N = 1;
h = b-a;
T1 = h/2*(f(a)+f(b));
S0 = T1;
while 1
    h = h/2;
    T2= T1/2;
    for k = 1:N
        T2 = T2 + h*f(a+(2*k-1)*h);
    end
    S = (4*T2-T1)/3;
    if abs(S-S0)<tol
        break
    end
    N = 2*N;
    T1 = T2;
    S0= S;
end

function c = newtonp(x,y)
%
% Input : x = [x0 x1 ... xN]
%         y = [y0 y1 ... yN]
% Output: n = Newton polynomial coefficients of degree n
%
n = length(x)-1;
N = n+1;
C = zeros(N,N );
C(1:N,1) = y';
for k = 2:N
    for m = 1: N+1-k % Divided Difference Table
        C(m,k) = (C(m + 1,k - 1) - C(m,k - 1))/(x(m + k - 1)- x(m));
    end
end
a = C(1,:); 
c = a(N); 
for k = n:-1:1 
    c = [c a(k)] - [0 c*x(k)]; 
end
c = fliplr(c);