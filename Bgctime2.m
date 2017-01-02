function Bgc=Bgctime2(t)%en gauss
global Torbite;
global B_tab;%Le champ est en nT
global freq
do='02-aug-2010 12:30:30';
d=datenum(do);
dn=datestr(d+1/(24*3600)*t); 
pos=position(t);
LLA=eci2lla(pos, dn);
Bgc=igrf11magm(LLA(3), LLA(1), LLA(2), 2010)e-9;




% compteur_mag=1+floor(360/Torbite*mod(t,Torbite));

% Bgc = 1e-9*[B_tab(compteur_mag,2) B_tab(compteur_mag,3) B_tab(compteur_mag,4)];4



end