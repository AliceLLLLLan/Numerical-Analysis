%f = @(x)1+ x + 0.5.*t.^2;
A = 1 + (1/2) + 0.5*(1/2)^2;
B=exp(1/2);
BE= (3^(1/2)*(1/2)^3)/6; %calculate the bound

difference=A-B; 

if difference <= BE
    fprintf('the bound is');
    disp(BE);
    fprintf('the difference is');
    disp(difference);
    fprintf('truncation error satisfies the bound from (a)');
else 
    fprintf('the bound is');
    disp(BE);
    fprintf('the difference is');
    disp(difference);
    fprintf('truncation error does not satisfy the bound from (a)');
end

