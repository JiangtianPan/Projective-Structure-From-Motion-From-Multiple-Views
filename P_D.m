function[P] =  P_D(D)

[U,W,V] = svd(D);
V=V';
W=W(1:3,1:3);
V=V(1:3,:);
P = W.^(0.5) * V;

end