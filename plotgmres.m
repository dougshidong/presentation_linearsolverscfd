close all;
clear;
rand('state',42)
n = 1000
%A = [2 0 0; 0 1 0; 0 0 1];
%A = diag(1*ones(1,n));
%A(1,1) = 1e-6;
%A = diag(1*rand(1,n));
%%% Pentadiagonal
width = 2
A = diag(5*ones(1,n));
A = diag(1*rand(1,n));
for i=1:width
  A = A + diag(1*ones(1,n-i),i) + diag(-2*ones(1,n-i),-i);
endfor



%%% Sparse
width = 3;
blocks_away1 = [0,1,round(n^(1/3))^2,round(n^(1/3))];
matrix = zeros(n);
row = 1;
while row < n
  col = row;
  for br = 1:length(blocks_away1)
    for dr=0:width-1
      r = row+dr+blocks_away1(br)*width;
      for bc = 1:length(blocks_away1)
        for dc=0:width-1
          c = col+dc+blocks_away1(bc)*width;
          matrix(r,c) = rand()*1;
        endfor
       endfor
    endfor
  endfor
  row = row + width;
endwhile
matrix = matrix(1:n,1:n);
A = matrix+diag(1*rand(1,n))+diag(5*ones(1,n));


A = rand(n,n);
A = matrix+diag(1*rand(1,n))+diag(100*ones(1,n));
A = A+A';
A(1,1) = 1e6;

precond = eye(n);
precond = diag(diag(A),n,n);
precond = sparse(precond);

A = sparse(A);
figure(2); spy(A);
eigenvalues = eig(A);
figure(1); plot(real(eigenvalues), imag(eigenvalues), 'o')
condition_number = cond(A)



b = rand(n,1);
x = b;%ones(n,1);


restart = 500;
tol = 1e-11;
maxit = 1;
[x, flag, relres, iter, resvec] = gmres(A,b,restart,tol,maxit,precond,precond,x);

figure(3); semilogy(0:length(resvec)-1,resvec);