function [ invq ] = invQ( q )
%fonction d'inversion du quaternion

if(q == 0)
    invq = 0;
else
    invq = 1/norm(q)*[-q(1) -q(2) -q(3) q(4)];
end




end

