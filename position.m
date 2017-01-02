function pos=position(t)
%Exprime la position dans le référentiel géocentrique en fonction du temps
Torbite=5400;
omegasat=2*pi/Torbite;
%On va créer un mouvement de rotation autour de l'axe
R1=rotx(8)*roty(omegasat*t*180/pi);
pos=R1*[0;0;(6380+300)*1e3];
% eci2lla
end