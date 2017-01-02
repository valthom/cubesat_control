function Bgc=Bgctime(t)%en gauss, dANS LE GEOGRAPHIQUE
global Torbite;
global B_tab;%Le champ est en nT
% compteur_mag=1+mod(floor(360*t/T)+90,360);
compteur_mag=1+floor(360/Torbite*mod(t,Torbite));
% compteur_mag=1;
Bgc = 1e-9*[B_tab(compteur_mag,2) B_tab(compteur_mag,3) B_tab(compteur_mag,4)];
end