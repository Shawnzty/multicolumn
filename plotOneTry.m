figure();    
plot(timeax,r_cond1,'Color','#0072BD');
    hold on
    plot(timeax,r_cond2,'Color','#D95319');
    plot(timeax,r_cond3,'Color','#EDB120');
    plot(timeax,r_cond4,'Color','#7E2F8E');
    plot(timeax,r_cond5,'Color','#77AC30');
    xlim([0 2000]);
    % axis([0 2000 0 0.2]);
    title("\Delta_{E} = " + num2str(Delta_e) + ', \Delta_{I} = '+ num2str(Delta_i) + ', I_{attn} = ' + num2str(Iattn));
    xlabel("Time (ms)");
    ylabel("Firing rate (Hz)");
    legend('Cond1','Cond2','Cond3','Cond4','Cond5','Location','northwest');
