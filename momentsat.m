function m=momentsat(cont, qo, qref, omegao, omegaref, Bsopasnorm)

    if(cont==1)
        KP=3e-7; KD=4.8e-5;
% KP=2.5e-4; KD=0.4; Tiens, ça marche aussi mais ça envoie fort
        dq = quatprod(invQ(qo), qref);
        tau=-KD*(omegao-omegaref)-KP*dq(1:3);
        
        m=cross3(Bsopasnorm, tau)/norm(Bsopasnorm)^2;
        %Parfait
%         dq=quatprod(invQ(q),qref);
%         m=(-4.8e-5*cross3(Bspasnorm, omega -omegaref)-3e-7*cross3(Bspasnorm, dq(1:3)))/norm(Bspasnorm)^2;
%             m=(-1e-4*cross3(Bsopasnorm, omegam-bo-omegaref)-2.5e-10*cross3(Bsopasnorm, dq(1:3)))/norm(Bsopasnorm)^2;
    else
        m=zeros(1,3);
    end
if(max(abs(m))>0.3)
    m = 0.3/max(abs(m))*m;
end

end