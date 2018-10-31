% We want extrema of f
f = @(t)sin(t)-t;
% Use Newton to solve f'(x) = 0 to find critical points
df = @(t)cos(t)-1; 
% second derivative for Newton
d2f = @(t)-sin(t); 

L = [];
X = [];
for i = -0.5:0.01:0.5
sol = findroot(f,df,i);
if isnan(sol)~=1
    % if sol is nan, then isnan(sol)=1
    L = [L,sol];
end
end

fprintf('The roots are:');
disp(L);
%since from the current guesses, we can see the the guesses are
%decreasing to zero digit by digit. Therefore, we are assuming that 
%the Newtwon iteration appear to be converging, and in the order of linear.

%To prove linear convergence
R=0; %THE TRUE ROOT
S = [];
for i= -0.5:0.01:0
    x1=findroot(f,df,i+0.01);
    x2=findroot(f,df,i);
    A= abs(x1-R);
    B= abs(x2-R);
    mu= A/(B);
    if ~isnan(mu)  
    S = [S,mu];
    end
end
B = mean2(S);
fprintf('The roots are:');
disp(L);
fprintf('To see the order of convergence without nan:');
disp(S);
fprintf('The approximate asymptotic constant of linear convergence without nan:');
disp(B);