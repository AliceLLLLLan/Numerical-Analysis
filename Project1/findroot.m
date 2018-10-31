function [oneRoot] = findroot(f,df,x0,maxDefect, nIterate)
% based on the code from Prof. Shane Kepley 10-Sep-2018
% define Newton iteration and set defaults
 if ~exist('maxDefect','var')
     % maxDefect parameter does not exist, so default it to something
      maxDefect = 1e-10;% defect bound
 end
 if ~exist('nIterate','var')
     % nIterate parameter does not exist, so default it to something
      nIterate = 100;% maximum iterates to try
 end

N = @(x)x - f(x)./df(x); % define handle for Newton map

oneRoot = nan; % default output if Newton fails
z=0; %indicator of oneroot
V = []; %create an empty vector to store all of the Newton iterates.

%% Newton iteration 
y0 = N(x0); % initalize Newton output

iDefect = abs(y0-x0); % initialize defect
iIterate = 1; % initialize iteration count

fprintf('Current guess: %.15f \n',x0);
V = [V, x0]; %store initial input x0 as the first element
fprintf('Current guess: %.15f \n',y0);
V = [V, y0]; %store initial Newton output y0 as the second element
% iterate a single initial guess until defect threshold is reached or max iterates
while iDefect > maxDefect && iIterate < nIterate
    x0 = y0; % update Newton input
    y0 = N(x0); % update Newton output
    fprintf('Current guess: %.15f \n',y0);
    V = [V, y0];
    iDefect = abs(y0-x0); % update defect
    iIterate = iIterate+1; % update iteration count
end

if iDefect < maxDefect % Newton succeeded
    oneRoot = y0; % return the root
    z=1; %indicator of oneroot
end

fprintf('Root: %.15f \n',oneRoot)

%asking for whether or not output V
% cite from https://www.mathworks.com/help/matlab/ref/input.html
%========ONLY USE FOR PROBLEM 1. FOR PROBLEM 2, BLOCK THE QUESTION=================
%{
prompt = 'Do you want to display all Newton iterates V? Y/N [Y]';
str = input(prompt,'s'); %returns the entered text, without evaluating the input as an expression.
if isempty(str) %if do not want to return anything
    str = 'N';
elseif str=='Y' && z==1 
    % in case str be 'N' or other value, use elseif, ad if there is a root, Oneroot~=nan
    fprintf('All Newton iterates V are');
    disp(V);
elseif z==0 %the case when oneroot==nan
    fprintf('There is no roots.');

end
%}


% plot functions
%========ONLY USE FOR PROBLEM 1. FOR PROBLEM 2, BLOCK THE PLOT=================
%{
close all
figure
hold on

% plot data
fplot(f,[-4,3])
fplot(N,[-4,3])
fplot(@(x)x,[-4,3])
scatter(oneRoot, 0,'r*')
axis([-4,3,-10,10])
xL = xlim;
line(xL,[0 0],'Color',[0,0,0]);  %x-axis
title(sprintf('t = %.15f, sin(t) = %.15f \n',oneRoot, sin(oneRoot)))
legend('f','Newton','y = x','x axis')

%% add sin plot
fplot(@(x)sin(x)-0.5,[-4,3],'LineStyle','--')
%}
end
