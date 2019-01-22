function x=linearsolver(U,b)
if rank(U)<size(U,1) % dim of row
    % a square matrix is invertible iff its rank = n
    error('Matrix input is singular')
end
if size(b,2)==1 % if dim of colomn = 1 or not / if the b is a vector or matrix
    tU = tril(U,-1);%select the lower matrix
    n = size(U,1); %n=#rows of U
    if abs(sum(sum(tU)))>eps % IF U IS NOT A UPPER TRIANGULAR MATRIX, DO Gaussian Elimination
        B=[U b];
        for ii=1:n-1 %COL#
            t=find(B(ii:end,ii))+ii-1; 
            %FIND RETURNS A COL VECTOR OF LINEAR INDICE OF THE MIN ELEMENT
            %ON COL II, SINCE START FROM B[II,II], THE REAL INDEX OF THE
            %MIN SHOULD BE [T+II-1,II]
            %t is the smallest integer with i<=t<=n and B(t,ii)!=0
            if isempty(t)==1 % if there is no such a t
               error('No unique solution exists')
            %there is unique solutions
            end
            if t(1)~=ii
                l=B(t(1),:);%Step 3 if P!=i swap
                B(t(1),:)=B(ii,:);
                B(ii,:)=l;
            end
            for j=ii+1:n % STEP 4
                mjii= B(j,ii)/ B(ii,ii); %step5
                B(j,ii:n+1)= B(j,ii:n+1)-mjii* B(ii,ii:n+1); %STEP6 SWAP
            end
        end
        
        for z=1:n %step7
              if B(z,z)==0
                  error('No unique solution exists')
              end
        end
        
        b=B(1:n,n+1);
        U=B(1:n,1:n); %Now 
        x = linearsolver(U,b);
    end
    %Now U is an upper triangular, and b is a vector
    for h=1:n %step 8
    x(h)=b(h)/U(h,h);
    end
    for i=(n-1):-1:1 %Step 9
        x(i)=b(i);
        for j=n:-1:(i+1)
            x(i)=x(i)-x(j)*U(i,j);
        end
        x(i)=x(i)/U(i,i);
    end
    x = x(:);
else % if the B is a matrix
    col = size(b,2);% if dim of colomn != 1
    x = zeros(size(U,1),size(b,2)); %output x is a matrix of #rows of U and #col of b
    for ii = 1:col 
        tb = b(:,ii); %FOR EACH COL, RUN linearsolver again
        x(:,ii) = linearsolver(U,tb); %call linearsolver again
    end
end