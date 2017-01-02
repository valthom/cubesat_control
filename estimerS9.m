function Sest=estimerS9(Sbody, sigma)
	Sbody = Sbody/norm(Sbody);
	Smes = zeros(9, 1);
	n1 = [1 1 0]/sqrt(2);
	n2 = [1 -1 0]/sqrt(2);
	n3 = [1 0 1]/sqrt(2);
	n4 = [1 0 -1]/sqrt(2);
	n5 = [0 1 0];
	n6 = [0 -1 0];
	n7 = [0 0 1];
	n8 = [0 0 -1];
	n9 = [-1 0 0];
	H=[n1; n2; n3; n4; n5; n6; n7; n8; n9];
	% disp(H);
	% disp(rank(H'*H));
	for i=1:9
	%     disp(Sbody');
	%     disp(H(i,:));
		Smes(i) = max(Sbody*H(i,:)', 0) + sigma*randn;
	end
	Smes = Smes/norm(Smes);
	% disp(Smes);
	% epsilon = 1e-1;
	Sest = (H'*H)\H'*Smes;
	Sest = Sest/norm(Sest);
	% disp('Erreur relative :');
	% disp(norm(Sest'-Sbody)/norm(Sbody));
end
