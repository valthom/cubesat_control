function res=luminosite(tt) % AJOUTER Torbite en PARAMETRE
global Torbite
temp = 80;
if(tt<Torbite/4-temp)
    res = 1;
else
    if(tt>Torbite/4+temp)
        res = 0;
    else
        res = -tt/(2*temp)+0.5+Torbite/(8*temp);
    end
end
end