function fplotbiais(vectTemps, vectb, vectbo)
%Tracé de vectb
    figure('color', 'white');
%     const=max(vectb(:));
    plot(vectTemps, vectb, vectTemps, vectbo, '-', 'linewidth', 2);
    title('$Convergence de l''estimation du biais$', 'interpreter', 'latex', 'fontsize',13);
    xlabel('Time $[T_0]$', 'interpreter', 'latex', 'fontsize',13);
    ylabel('Différence entre observation et biais réel', 'fontsize',13);
    legend('bx', 'by', 'bz', 'box', 'boy', 'boz');
    grid
end