function Kgrad=gradientgrav(qorbsat)


%% Calcul du gradient % PARAM
global gradient

if(gradient)
   
    %définition du quaternion de rotation entre le repere orbital et le
    %repere du satellite
    
    %definition du vecteur associe (cf rapport)
    zrot = [(2*(-qorbsat(4)*qorbsat(2)+qorbsat(1)*qorbsat(3)));(2*(qorbsat(2)*qorbsat(3)+qorbsat(4)*qorbsat(1)));(1-2*qorbsat(1)^2-2*qorbsat(2)^2)];
    om0 = sqrt(6.67e-11*5.97e24/((6370e3+250e3)^(3))); %
    I=getInertie();
    Kgrad = 3*om0^2*cross3(zrot,I*zrot);
   
else
    Kgrad=[0;0;0];
end
end