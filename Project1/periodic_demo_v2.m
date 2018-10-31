% define function handles to pass to Newton
f = @(t)-64.*t.^4 + 128.*t.^3 - 80.*t.^2 +15.*t; 
df = @(t)(-256).*t.^3 + 384.*t.^2 - 160.*t + 15; 
coeff = [-64 128 -80 15 0];

% choose some parameters
R000 = [];
R034 = [];
R075 = [];
R090 = [];
Relse = [];
L = [];
count=0;
%Generate values from the uniform distribution on the interval [0.8, 1]:
for i = 1:5
% use Newton to find one root
initialdata = 0.8 + (1-0.8).*rand(1);%Generate values from the uniform distribution on the interval [0.8, 1]:
sol = findroot(f,df,initialdata);

if ~isnan(sol)
% if newtown  gives a solution
%Record the root
L = [L,sol];
if sol >= -0.1 && sol < 0.17
    R000 = [R000, sol];
elseif sol >= 0.17 && sol < 0.545
    R034 = [R034, sol];
elseif sol >= 0.545 && sol < 0.825
    R075 = [R075, sol];
elseif sol >= 0.825 && sol < 1
    R090 = [R090, sol];
else
    Relse = [Relse, sol];
end
%deteling the generated root
% delete the just FOUND root
coeff = deconv(coeff,[1,-sol]);
% define function handles to pass to Newton
f = @(x)polyval(coeff, x); % define handle for polynomial evaluation
dp = polyder(coeff); % coefficients for derivative
df = @(x)polyval(dp, x); % define handle to derivative

else %if newtown does not give a solution
    if count > 3
        break
    else
    count=count +1;
    end
end
end

szR000=size(R000);
szR034=size(R034);
szR075=size(R075);
szR090=size(R090);
szRelse=size(Relse);
%fprintf('The number of trials which converge to each of the four solutions are:');
fprintf('The number of trials which converge to 0:');
disp(szR000(2));
fprintf('The number of trials which converge to 0.345:');
disp(szR034(2));
fprintf('The number of trials which converge to 0.75:');
disp(szR075(2));
fprintf('The number of trials which converge to 0.9045:');
disp(szR090(2));
fprintf('The number of trials which does not converge to any of these four solutions:');
disp(szRelse(2));
disp(L);
