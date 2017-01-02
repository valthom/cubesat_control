function tracerlyapu(vectq,vectomega)
I=getInertie();
w0= sqrt(6.67e-11*5.97e24/((6370e3+250e3)^(3)));
% disp(size(vectq));
% disp(size(vectomega));
time=1:size(vectq,2);
time=time/5400;
lyapu=zeros(size(time));
% disp(size(time));
for j=1:size(vectq, 2)
    qorbsat=vectq(:,j);
    omega=vectomega(:,j)-[0;2*pi/5400;0];
    c3 = [(2*(-qorbsat(4)*qorbsat(2)+qorbsat(1)*qorbsat(3)));(2*(qorbsat(2)*qorbsat(3)+qorbsat(4)*qorbsat(1)));1-2*qorbsat(1)^2-2*qorbsat(2)^2];
    c2=[2*(qorbsat(4)*qorbsat(3)+qorbsat(1)*qorbsat(2));1-2*(qorbsat(1)^2+qorbsat(3)^2);2*(qorbsat(3)*qorbsat(2)-qorbsat(1)*qorbsat(4))];
    lyapu(j)=.5*omega'*I*omega+3/2*w0^2*c3'*I*c3-1/2*w0^2*c2'*I*c2+1/2*w0^2*(I(2)-3*I(3))+0.6*5e-7*((qorbsat(1:3)'*qorbsat(1:3)+1-qorbsat(4)^2));
end


figure('color', 'white');
subplot(211);
% figure('color', 'white');
plot(time,(lyapu), 'linewidth', 2);
title('Lyapunov');
xlabel('Time $[T_0]$', 'interpreter', 'latex', 'fontsize',13);
ylabel('$\textbf{V}$', 'interpreter', 'latex', 'fontsize',13);

subplot(212);
plot(time,log10(lyapu), 'linewidth', 2);
title('log(Lyapunov)');
xlabel('Time $[T_0]$', 'interpreter', 'latex', 'fontsize',13);
ylabel('$\log(\textbf{V})$', 'interpreter', 'latex', 'fontsize',13);
end
    