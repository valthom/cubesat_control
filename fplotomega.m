function fplotomega(vectTemps, vectomega, vectomegao, vectdiffb)
    figure('color', 'white');
    subplot(211);
    plot(vectTemps,vectomega, vectTemps, vectomegao, '--', 'linewidth', 2);
    title('Evolution of $\omega$', 'interpreter', 'latex', 'fontsize',13);
    xlabel('Time $[T_0]$', 'interpreter', 'latex', 'fontsize',13);
    ylabel('$\omega$', 'interpreter', 'latex', 'fontsize',13);
    legend('X', 'Y', 'Z', 'Xo', 'Yo', 'Zo');
    grid
    
    subplot(212);
    plot(vectTemps,.5*log10(  sum( ( vectomegao-vectomega ) ).^2 ), vectTemps, .5*log10(sum(vectdiffb.^2)), 'linewidth', 2);
    title('$\log(||\omega-\omega_{ref}||) et \log(||\widehat{b}-b||)$', 'interpreter', 'latex', 'fontsize',13);
    xlabel('Time $[T_0]$', 'interpreter', 'latex', 'fontsize',13);
    ylabel('$\log(\epsilon)$', 'interpreter', 'latex', 'fontsize',13);
    legend('log(error(omega))', 'log(error(b))');
    grid
end