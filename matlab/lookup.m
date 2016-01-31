function Y = lookup(L, Lvector, X, Xmatrix, Ymatrix) 

idx1 = max(find(Lvector <= L));
idx2 = min(find(Lvector >= L));
Y1 = interp1(Xmatrix(:,idx1), Ymatrix(:, idx1), X);
Y2 = interp1(Xmatrix(:,idx2), Ymatrix(:, idx2), X);
if Y1 == Y2
   Y = Y1;
else        
   Y = interp1( [Lvector(idx1) Lvector(idx2)], [Y1 Y2], L);
end
return

