function mag=champmag(t)

pos=position(t);
sec=mod(t,3600);
hour=mod((t-sec)/3600,24);
jour=(t-sec-hour*3600)/(24*3600);
utc=[2015, 12, 9, 10+jour, 00+hour, 00+sec];
x=pos(1); y=pos(2); z=pos(3);
LLA=eci2lla([x, y, z], utc);
mag=igrf11magm(LLA(3), LLA(1), LLA(2), utc(1))*1e-9;
%Attention ce n'est pas exprimé dans un référentiel inertiel
end