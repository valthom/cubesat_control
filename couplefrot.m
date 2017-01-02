function Kfrot=couplefrot(t, qorbsat)
global Cd
global frot
if(frot)
    v= (7.8e3); % A DEFINIR AVEC LES AUTRES PARAMETRES, avec sa direction
    coeffdrag2=.5*Cd*airdensity(t)*(v^2);
    n1 = [1;0;0];
    n2 = [0;1;0];
    n3 = [0;0;1];
    uv = QrotInv(qorbsat,[1 0 0]); %expression de la vitesse dans le repère satellite
    uv = uv/norm(uv); 
    surf1=.1*.1; surf2=.1*.2; surf3=surf2; %PARAMETRE : geometrie satellite
    central=[-1e-2, 0, 0]; % PARAMETRE
    Kfrot1=coeffdrag2*surf1*dot(uv,n1)*cross3(uv, central);
    Kfrot2=coeffdrag2*surf2*dot(uv,n2)*cross3(uv, central);
    Kfrot3=coeffdrag2*surf3*dot(uv,n3)*cross3(uv, central);
    Kfrot = Kfrot1+Kfrot2+Kfrot3;     
else
    Kfrot = zeros(1,3);
end

end