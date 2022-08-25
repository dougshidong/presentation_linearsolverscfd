n = 100;
marker = 's'; markersize = 4;
%%% matrix
matrix = eye(n,n);
f1 = figure(1); spy(matrix,marker,markersize); axis('equal');
print(f1, "identity.pdf", "-dpdf","-tight","-S500,500");

%%% Pentadiagonal
width = 2
matrix = diag(1*ones(1,n));
for i=1:width
  matrix = matrix + diag(1*ones(1,n-i),i) + diag(2*ones(1,n-i),-i);
endfor
f2 = figure(2); spy(matrix,marker,markersize); axis('equal')
print(f2, "pentadiagonal.pdf", "-dpdf","-tight","-S500,500");

%%% Lower, Upper
matrix = tril(rand(n));
f3 = figure(2); spy(matrix,marker,markersize); axis('equal')
print(f3, "lower_triangular.pdf", "-dpdf","-tight","-S500,500");
matrix = triu(rand(n));
f4 = figure(4); spy(matrix,marker,markersize); axis('equal')
print(f4, "upper_triangular.pdf", "-dpdf","-tight","-S500,500");

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
          matrix(r,c) = 1;
        endfor
       endfor
    endfor
  endfor
  row = row + width;
endwhile
matrix = matrix(1:n,1:n);
f5 = figure(5); spy(matrix,marker,markersize); axis('equal')
print(f5, "sparse.pdf", "-dpdf","-tight","-S500,500");

matrix = rand(n);
f6 = figure(2); spy(matrix,marker,markersize); axis('equal')
print(f6, "dense.pdf", "-dpdf","-tight","-S500,500");

%%% Discontinuous Galerkin
width = 5
matrix = diag(1*ones(1,n));
i = 1;
while i<n
    for wr = 0:width-1
    for wc = 0:width-1
      r = i+wr;
      c = i+wc;
      matrix(r,c) = 1;
    endfor
  endfor
  i=i+width
endwhile
f7 = figure(7); spy(matrix,marker,markersize); axis('equal')
print(f7, "dg.pdf", "-dpdf","-tight","-S500,500");


%%% Discontinuous Galerkin
identity = eye(n,n);
dense = rand(n,n);
matrix = [horzcat(dense, identity); horzcat(identity, dense)];
f8 = figure(8); spy(matrix,marker,markersize); axis('equal')
print(f8, "schur.pdf", "-dpdf","-tight","-S500,500");