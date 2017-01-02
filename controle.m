% principe : on active le contrôle 65% du temps

function cont=controle(t) % METTRE Torbite en paramètre
cont=0;
global Torbite
% if( (t>=Torbite && t<5*Torbite) || (t>7*Torbite && t<8*Torbite) || (t>10*Torbite && t<11*Torbite) )
% if t>1*Torbite && (mod(t, 100)/100)>0.3
% if (mod(t, 100)/100)>0.3
%     cont=1;
% end
if (mod(t, 200)/200)>0.35 && t>.5*Torbite %&& t>Torbite*1.5
    cont=1;
end

end