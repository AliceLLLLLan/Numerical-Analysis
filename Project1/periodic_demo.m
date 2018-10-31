% f(t) = -64*x^4 +128*x^3 - 80*x^2 +15*x
% f'(t) = ?256*x^3 + 384*x^2 - 160*x + 15
% f''(t) = -768*x^2 + 768*x - 160

% define function handles
% We want extrema of f
f = @(t)-64.*t.^4 + 128.*t.^3 - 80.*t.^2 +15.*t; 
df = @(t)(-256).*t.^3 + 384.*t.^2 - 160.*t + 15; 
% second derivative for Newton
d2f = @(t)-768.*t.^2 + 768.*t - 160; 

% choose some parameters
%these are intervals of four roots
R000 = [];
R034 = [];
R075 = [];
R090 = [];
Relse = [];
L = [];
%Generate values from the uniform distribution on the interval [0.8, 1]:
for i = 1:1000
initialdata = 0.8 + (1-0.8).*rand(1);%Generate values from the uniform distribution on the interval [0.8, 1]:
sol = findroot(f,df,initialdata);
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