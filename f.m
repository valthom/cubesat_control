function dX=f(t,X)

% EN ARGUMENT
global sigmamagneto
global sigmasolaire
global kB kP kI kS
global moment

%On redécompse X en ses différentes valeurs
q=X(1:4)';
omega=X(5:7)';
b=X(8:10)';
qo=X(11:14)';
bo=X(15:17)';
qref=X(18:21)';
omegaref=X(22:24)';
So=X(25:27)';
Bo=X(28:30)';
omegao=X(31:33)';

global vecsave % SUPERFLU
if mod(t,1)==0 && t>0
%     disp(size(vecsave))
vecsave(t, :)=[q, omega];
end

%Test au cas où la norme du quaternion explose (problème de schéma
%numérique) % VOIR SI CE TEST EST UTILE
if(norm(qo)>1.3)
    disp('-------------------------------------------');
    fprintf('t=%.1f\n', t);
    disp('q=');
    disp(q);
    disp('qo=');
    disp(qo);
    return
end

%% Lecture des mesures des capteurs
%Mesure de omega
omegam=mesureGyro(omega, b);



%Magnetometer
Bgc=Bgctime(t); % TABLE A PRENDRE DANS L'INERTIEL
Bspasnorm=QrotInv(q,Bgc); % dans le body
Bs=Bspasnorm+sigmamagneto*randn(1,3); % REFLECHIR à une bonne simu de bruit
if(norm(Bs)~=0)
    Bs=Bs/norm(Bs);
end


Bso=QrotInv(qo,Bgc); %"Estimée" de Bs cf notation de l'article
Bsopasnorm=Bso; %Notatioin un peu sale : le vecteur que l'on ne renorme pas
if(norm(Bso)~=0)
    Bso=Bso/norm(Bso);
end

%Sun sensors
Sgc=Sgctime(t); % DANS L'INERTIEL
Ss = QrotInv(q,Sgc)+sigmasolaire*randn(1,3); % SIMULER BRUIT ORTHOGONAL 
% Ss = estimerS9(Ss, sigmasolaire)'; % SEUIL ?
Ss = Ss/norm(Ss);
Sso= QrotInv(qo,Sgc);%"EstimÃ©e" de Ss idem
Sso = Sso/norm(Sso);%on norme ces vecteurs


%% Choix des gains de l'observateur [Martin]
kPi=kP;

% kIi=0.003/10;
kIi=kI;
kBi=kB*(1-controle(t));%+kSi;
% kBi=kB;
kSi=kS*decroissancejour(t)/8;
global Torbite

if t>Torbite/3
    kPi=kP/3;
    kIi=kIi/12;
    kSi=kS*decroissancejour(t)/12;
    kBi=kB/3*(1-controle(t));
end

if t<2*Torbite
    kIi=5*kI;
end

%%%%%%%Control%%%%%%


%% CALCUL DU CONTROLE U
%calcul de l'ecart par rapport a l'etat de reference
m=momentsat(controle(t), qo, qref, omegam-bo, omegaref, Bsopasnorm);


%%%%%%%%%%%Erreur sur le moment=Erreur de contrôle (Skype X-Mines)
%Ici c'est une erreur de contrôle statique, a essayer avec un bruit blanc
% donc la variance est adéquate
% m(1)=1.3*m(1);
% m(2)=0.8*m(2);
% m(3)=1.1*m(3);
%%%%%%%%%


moment=m';
Kt = cross3(m',Bspasnorm');
Ks= Kt';

%Evaluation du moment dû au gradient de gravité
%qorbsat quaternion passage de orbital à body
qorbsat = quatprod(invQ(qref),q);
Kgrad=gradientgrav(qorbsat);
Ks = Kgrad'+Ks;
%% Calcul des frottements

Kfrot=couplefrot(t, qorbsat);
Ks = Kfrot+Ks; 
%% On ajoute un couple constant : celui des circuits
global circuit
Ks=Ks+cross3([4e-4,-4e-4,4e-4]/4,Bspasnorm)*circuit/sqrt(3); % FAIRE UNE FONCTION


%% Observateur
%Notations du papier de recherche [hamel]
wmes=kBi*cross3(Bs,Bso)+kSi*cross3(Ss,Sso);
% wmes2=kBi*cross3(Bs,Bo)+kSi*cross3(Ss,So);

kLB=5e-3; % DEFINIR AVANT
kLS=kLB; % AUSSI

dX(25:27)=cross3(Ss, omegao) - kLS*(So-Ss)+.1*(1-norm(So)^2)*So;
dX(28:30)=cross3(Bs, omegao) - kLB*(Bo-Bs) + QrotInv(q,derivB(t))+.1*(1-norm(Bo)^2)*Bo;% CALCUL DE derivB à revoir
if(decroissancejour(t)==0) % A FAIRE AVANT l'assignation précédente
    dX(25:27)=cross3(So, omegao);
end
if controle(t)==1 % dans ce cas : pas de mesure magneto. A FAIRE AVANT
        dX(28:30)=cross3(Bo, omegao);%+QrotInv(derivB(t)); % attention à QrotInv : deux arguments
end

I=getInertie();
% wo
dX(31:33) = I\(cross3(I*omegao',omegao')+Kt) +( kLS^2 * cross3(Ss, (So-Ss)) + kLB^2 * cross3(Bs, (Bo-Bs)) )';


dX(22:24)=[0 0 0]; % wref
dX(18:21)=1/2*quatprod(qref, [omegaref 0])+(1-norm(qref)^2)*qref;


dX(5:7) = I\(cross3(I*omega',omega')+Ks'); % w
dX(1:4)=1/2*quatprod(q, [omega 0])+(1-norm(q)^2)*q;

dX(8:10)=[0 0 0];%le biais constant (lentement variable)
%dX(8:10)=10^-4*randn(1,3); %le biais est un mouvement brownien (lentement variable)
dX(11:14)=1/2*quatprod(qo,[omegam-bo + kPi*wmes 0])+(1-norm(qo)^2)*qo;%observateur
%de l'article sur le quaternion + un terme de normalisation
dX(15:17)=-kIi*wmes;%observateur de l'article
% disp(dX);
dX=dX';

end
