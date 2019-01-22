function [x,X,its] = findroot(f,varargin)
% findroot is designed for
% Newton's method with derivative or approximate derivative
% which is capable of dealing with the two input cases
% 
%  [x,X,its] = findroot(f,df,x0,epsi,N)
%  [x,X,its] = findroot(f,x0,epsi,N)
% input:
%   f: function
%   df: derivative function
%   x0: intial guess
%   epsi: stop criteria |f(x)|<epsi or |x-xn|<epsi
%   N: maximum iteration limit, default = 100
% output:
%   x: the root
%   X: iteration history
%   its: iteration number
%
% 2018-10-13
%
if ~isa(varargin{1},'function_handle') % if the 2nd input isn't a function object
    % use this process to solve
    
    epsi = 1e-10; %
    N = 100;
    h = 1e-3; % increment of approximating of the derivative
    x0 = varargin{1};
    x = x0; % iteration
    X = x0; % iteration history
    for its = 1:N
        df = (f(x+h)-f(x-h))/(2*h); % approximate derivative use central difference scheme
        xn = x - f(x)/df;           % Newton's step to update the solution
        if abs(f(xn))<epsi || abs(x-xn)<epsi
            x  = xn;
            X  = [X x];             % record the iteration history
            break
        end
        x  = xn;
        X  = [X x];                 % record the iteration history
    end
else % if the 2nd input is a funciton, following this process
    if nargin == 3
        epsi = 1e-10;
        N = 100;
    else epsi = varargin{3}; 
        N = varargin{4};
    end
    df = varargin{1};
    x0 = varargin{2};
    x = x0; % updated iteration
    X = x0; % record the iteration 
    for its = 1:N
        xn = x - f(x)/df(x);         % Newton's step to update the solution
        if abs(f(xn))<epsi || abs(x-xn)<epsi
            x  = xn;
            X  = [X x];              % record the iteration history
            break
        end
    end
end
% if the itetation doesn't meet the limit, returns NaN as the solution
if its == N
    x = NaN;
end
