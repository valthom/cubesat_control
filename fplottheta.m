function fplottheta(vectTemps, vecjour, theta, thetaref)
%     const=max(theta);
    const=5;
    %Pointing knowledge error [°]
    figure('color', 'white');
    %vectTemps, 2.1*veccontrol, 'k',
    
    subplot(211);
    plot( vectTemps, const*vecjour, 'r--',  vectTemps, theta, vectTemps, thetaref, 'linewidth', 2);
    xlabel('Time $[T_0]$', 'interpreter', 'latex', 'fontsize',13);
    ylabel('Pointing knowledge error [°]');
    legend('Light Intensity', 'Pointing knowledge error', 'Pointing accuracy error');
    grid
    title('Pointing error ');
    
    
    subplot(212);
    plot(vectTemps, log10(theta/180), vectTemps, log10(thetaref/180), 'linewidth', 2);
    xlabel('Time $[T_0]$', 'interpreter', 'latex', 'fontsize',13);
    ylabel('log(Pointing error [°]/180)');
    legend('log(Pointing knowledge error/180)', 'log(Pointing accuracy error/180)');
    grid
    title('log(Pointing error/180)');
    
end