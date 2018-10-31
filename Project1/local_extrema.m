%local_extrema
% Find local extrema of f(t) = exp((-t)*cos(pi*t))
% f'(t) = exp((-t)*cos(pi*t))*(pi*t*sin(pi*t)-cos(pi*t))
% f''(t) = exp((-t)*cos(pi*t))*(pi*t*sin(pi*t)-cos(pi*t))^2+exp((-t)*cos(pi*t))*(2*pi*sin(pi*t)+(pi^2)*t*cos(pi*t))

% choose some parameters
plotIn = [0,4];

% define function handles
% We want extrema of f
f = @(t)exp((-t).*cos(pi.*t)); 
% Use Newton to solve f'(x) = 0 to find critical points
df = @(t)exp((-t).*cos(pi.*t)) .* (pi.*t.*sin(pi.*t)-cos(pi.*t)); 
% second derivative for Newton
d2f = @(t)exp((-t).*cos(pi.*t)) .* (pi.*t.*sin(pi.*t)-cos(pi.*t)).^2 + exp((-t).*cos(pi.*t)) .* (2.*pi.*sin(pi.*t)+ (pi.^2).*t.*cos(pi.*t)); 
T = linspace(plotIn(1), plotIn(2), 1000);

% plot
close all
figure
hold on
plot(T, f(T)) % plot f
plot(T, df(T)) % plot f
% plot(T, df(T)) % plot f'
line(plotIn, [0,0], 'Color',' k') % x-axis


% find and plot some roots of f'
%initData = linspace(plotIn(1), plotIn(2), 100);
L = [];

%do newton iterates on [0,4] to find roots. L will sotre all the roots
for i = 0:0.1:4
sol = findroot(df,d2f,i); 
    L = [L,sol];
end

digits(4);
vpa(L);
unique(L);

R1 = [];
R2 = [];
R3 = [];
R4 = [];
Relse = [];

%from the graph of df, we can see that there are four roots fall into
%different intervals
for i = 1:length(L)
    if L(i)>0.1 && L(i)<0.4
        R1 = [R1,L(i)];
    elseif   L(i)>1 && L(i)<1.25
        R2 = [R2,L(i)];
    elseif   L(i)>2 && L(i)<2.25
        R3 = [R3,L(i)];
    elseif   L(i)>3 && L(i)<3.25
        R4 = [R4,L(i)];
    else
        Relse = [Relse,L(i)];
    end
end

D=[R1(1) R2(1) R3(1) R4(1)];
fprintf('The local extrema are:');
disp(D);