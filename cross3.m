function res=cross3(x,y)%Une version plus rapide du produit vectoriel en dim 3
res=zeros(size(x));
res(1)=x(2)*y(3)-x(3)*y(2);
res(2)=y(1)*x(3)-y(3)*x(1);
res(3)=x(1)*y(2)-x(2)*y(1);
end
