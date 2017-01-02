% conjugaison d'un vecteur de R^3 x par un quaternion q
% input :      q normé de taille 1x4, partie réelle en dernière coordonnée
%              x de taille 1x3
% output : X = q*xq de taille 1x3


function [X] = QrotInv(q,x)
n = norm(q);
q0 = q(4)/n;
v = -q(1:3)/n;

X = 2*(v*x')*v + (q0^2-norm(v)^2)*x + 2*q0*cross3(v,x);
end

