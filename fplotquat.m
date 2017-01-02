function fplotquat(vectTemps, vectqknow, vectqacc)

    %Tracé de vectq
    figure('color', 'white');
    
    subplot(211);
    plot(vectTemps,vectqknow, 'linewidth', 2);
    title('Quaternion knowledge error', 'interpreter', 'latex', 'fontsize',13);
    xlabel('Time $[T_0]$', 'interpreter', 'latex', 'fontsize',13);
    ylabel('$\widehat{q}^{-1} q$', 'interpreter', 'latex', 'fontsize',13);
    legend('err1', 'err2', 'err3', 'err4');
    grid
    
    subplot(212);
    plot(vectTemps,vectqacc, 'linewidth', 2);
    title('Quaternion accuracy error', 'interpreter', 'latex', 'fontsize',13);
    xlabel('Time $[T_0]$', 'interpreter', 'latex', 'fontsize',13);
    ylabel('$q_{ref}^{-1} q$', 'interpreter', 'latex', 'fontsize',13);
    legend('err1', 'err2', 'err3', 'err4');
    grid
end