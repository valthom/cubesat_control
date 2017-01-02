%Simulation de l'observateur non linéaire.
clc

global Torbite
Torbite=5400;

duree=15*Torbite;




%% ===Définition des variables et initialisation===

%On doit redéclarer ces variables pour qu'elles soient globales

global Ttot
Ttot=duree;%La durée que je rajoute à la fin pour voir si ça reconverge
global moment
moment=zeros(1,3);

fe=1;%Fréquence d'échantillonnage 
global freq
freq=fe;



%% ===Plot des courbes===
plotomega=1;
plotbiais=1;
plotquat=1;%plot q
plottheta=1;%pointing knowlege error
plotmoment=1;
plotforces=0;
plotenergie=0;
plotlyapu=0;

global boolplot
boolplot=[plotbiais, plotquat, plotomega, plottheta, plotforces, plotenergie, plotmoment, plotlyapu];

%% Dynamiques perturbatrices
global gradient frot circuit
gradient=1;
frot=1;
circuit=1;

%% ====Gains du filtre===
global kB kS kI kP
kB=0.3; kS=0.1; kI=3e-4; kP=1;%Attention, kI sera à choisir en fonction de la dérive de biais de gyro (à estimer)


%% =Variance des bruits=

%Bruit sur les gyros
global sigmagyro;
sigmagyro=0.011*(pi/180)*sqrt(fe);
% fprintf('Ecart-type du bruit de gyro : %f\n', sigmagyro);

%Bruit sur le magnéto
global sigmamagneto
sigmamagneto=5e-3*sqrt(fe)*1e-4;%En Tesla

%Bruit sur le capteur solaire
global sigmasolaire
sigmasolaire=5e-2*sqrt(fe);

%Coefficient aérodynamique global % A DECLARER AILLEURS
global Cd
Cd=2.2;

% %% ===Tables de B===
% global B_tab; % A REFAIRE + LA DERIVEE
% B_tab = textread('dataMag.csv','','delimiter',';');

%===Etat Initial===
fprintf('==============================================\n');

fprintf('Initialisation partiellement aléatoire des conditions initiales\n');


%Quaternion définissantla matrice de rotation
q = [2*(rand(1,4)-.5)];
% q=[3 6 -4 -700];
% q=[0 0 0 1];
q=q/norm(q);
disp('Quaternion initial :');
disp(q);
theta0=norm(2*asin(norm(q(1:3)))*180/pi);
fprintf('Erreur initiale de %f ° \n', theta0);
qref=[0 0 0 1];
omegaref=[0 2*pi/Torbite 0];

%Vecteur rotation du satellite
omega =[0 2*pi/Torbite 0]*0+5e-3*randn(1,3);
%omega=[30 -30 30]*pi/180+5e-1*randn(1,3);
fprintf('\nOmega inital x1000:\n');
disp(1000*omega);
fprintf('\nOmega de référence x1000:\n');
disp(1000*omegaref);
fprintf('Norme de l erreur initiale sur omega : %e \n', norm(omega-omegaref));
%Biais de mesure sur omega
b = 5e-4*randn(1,3);
fprintf('\nBiais :\n');
disp(b);
%Observateur pour le quaternion
qo =[0 0 0 1];
%Observateur pour le biais :
bo = zeros(1,3);



%Définition de l'état X initial
omegao=omega+sigmagyro*randn(size(omega));
So=  QrotInv(qo,Sgctime(0))+sigmasolaire*randn(1,3);
Bo = QrotInv(qo,Bgctime(0))+sigmamagneto*randn(1,3);
X = [q omega b qo bo qref omegaref So Bo omegao]';


%=Constantes pour l'intégration=


pas=1/fe;%Période d'échantillonnage % A DISTINGUER DU PAS d ECHANTILLONNAGE
n=int64(Ttot*fe);%nombre d'itérations Ttot = duree ?
vectTemps= 0:pas:Ttot;%Vecteur stockant les points de temps % CHANGER LA DEFINITION
global vecteurTemps
vecteurTemps=vectTemps; % c'est sale, c'est le vecteur utilisé dans 
%f pour trouver index
vectX=zeros(length(X), length(vectTemps));
vectX(:,1)=X;%Vecteur stockant l'état X à chaque itération


vecjour=ones(size(vectTemps));
veccontrol=zeros(size(vectTemps));
vectmoment=zeros(3, length(vectTemps));
%===Résolution de l'équation différentielle avec RK4===
global vecsave
vecsave=zeros(duree, 7); % ATTENTION duree est à remplacer par le nombre d'itérations


t=0;%initialisation du temps
for i=2:(n+1)%Subtilité avec le nombre d'itérations,faut être sûr qu'on a le même...
                %nombre de points de temps et d'itérations. 
    touslesxpourcents=5;
    if(mod(100*i/touslesxpourcents,n)==0)
        fprintf('\nLoading...%d%%\n',100*i/(n+1));
    end
    k1 = f(t,X);
    k2 = f(t + pas/2 , X + (pas/2)*k1);
    k3 = f(t + pas/2 , X + (pas/2)*k2);
    k4 = f(t + pas , X + pas*k3);
    X = X + (pas/6) * (k1 + 2*k2 + 2*k3 + k4);
    vecjour(i)=decroissancejour(t);
    veccontrol(i)=controle(t); % booléen qui indique si le contrôle est actif
    t=t+pas;
    vectX(:,i)=X;
    vectmoment(:,i)=moment;
end;

vectTemps=vectTemps/Torbite;
%===Output de la fonction===
Xfinal=vectX(:,n+1);
% vecdata=cell2mat(mf.data);
csvwrite('datatab2.csv', vecsave);

plotall(fe, vectTemps, vectX, vecjour, vectmoment)












