f = @(x)((3.^x).*(x.^3))./6 - (10.^(-2));
df = @(x)((3.^(x)).*(x.^2))/2+(log(3).*(x.^3).*(3.^(x-1)))/2;

%by graphing f, we could find an approx root for f as x0 to put into
%findroot function
plotIn = [0.2,0.4];
x = linspace(plotIn(1), plotIn(2), 1000);
% plot
close all
figure
hold on
plot(x, f(x)) % plot f
%plot(T, df()) 
% plot(T, df(T)) % plot f'
line(plotIn, [0,0], 'Color',' k') % x-axis

Largest=findroot(f,df,0.2);
% since from the graph we could see that (3.^x).*(x.^3)-1/(60.^2)<=0 if
% x<=0.345, therefore, the largest value b =0.345