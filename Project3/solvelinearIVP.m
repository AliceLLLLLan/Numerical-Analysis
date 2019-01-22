function [x]=solvelinearIVP(A,x0)
[v,l] = eig(A);
x = @(t) v*diag(exp(t.*diag(l)))*inv(v)*x0;