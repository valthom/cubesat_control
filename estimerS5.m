function Sest=estimerS5(Sbody, sigma)
Sbody = Sbody/norm(Sbody);
Smes = zeros(6, 1);
n1 = [0 1 0];
n2 = [0 -1 0];
n3 = [0 0 1];
n4 = [0 0 -1];
n5 = [-1 0 0];
n6 = [1 0 0];

H=[n1; n2; n3; n4; n5; n6];
% disp(H);
% disp(rank(H'*H));
for i=1:6
%     disp(Sbody');
%     disp(H(i,:));
    Smes(i) = max(Sbody*H(i,:)', 0) + sigma*randn();
end
% disp('Avant')
% disp(Smes)
Smes(6) = sqrt(1 - min(norm(Smes(1:5))^2,1));
% disp('Après')
% disp(Smes)
Smes = Smes/norm(Smes);
% disp(Smes);
% epsilon = 1e-1;
Sest = (H'*H)\H'*Smes;
Sest = Sest/norm(Sest);
% disp('Erreur relative :');
% disp(norm(Sest'-Sbody)/norm(Sbody));