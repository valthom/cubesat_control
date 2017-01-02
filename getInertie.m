function [ I] = getInertie() % PAS COHERENT AVEC UN CENTRE d'INERTIE DECENTRE
%cette fonction renvoie la matrice d'inertie du satellite

m = 2 ; %masse du satellite
l1 = 0.2 ; %dimensions du satellite
l2 = 0.1 ; 
% l3 = 0.11 ;
l3=0.1;

I1 = m*(l2^2 + l3^2)/12;
I2 = m*(l1^2 + l3^2)/12;
I3 = m*(l2^2 + l1^2)/12;


% I = [ I1 0 0 ;
%       0 I2 0 ;
%       0 0 I3 ];
%   
  
I = [ I1 0 0 ;
      0 I2 0 ;
      0 0 I3 ];
  

end

