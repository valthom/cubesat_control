function [ q ] = quatprod( q1 , q2 )
%fonction définissant la multiplication entre deux quaternions

q = zeros(1,4);
u1 = q1(1:3);
u2 = q2(1:3);

q = [(q1(4)*u2 + q2(4)* u1 +cross3(u1,u2)) (q1(4)*q2(4)-u1*u2')];



end

