clear;
close all;
clc;
initime = clock;
addpath('funcs');

%% changeable parameter settings
% for parfor
Delta_e = 0.1;
Delta_i = 0.011; % none % changable
Iattn = 0.02;

time = 10000;

disp("Computing -- Delta_e:"+num2str(Delta_e)+", Delta_i:"+num2str(Delta_i)+", Iattn:"+num2str(Iattn));

[r,v,g] = once(Delta_e, Delta_i, Iattn, time);

%% plot
popName = {'1L23e','1L23i','1L4e','1L4i','1L5e','1L5i','1L6e','1L6i', ...
    '2L23e','2L23i','2L4e','2L4i','2L5e','2L5i','2L6e','2L6i'};
pop = 5;

dt = 0.01;
timeax = 0:dt:time;
timeax = timeax';
stimIn = 1000;
stimDur = time - stimIn;
step_stimIn = stimIn/dt;
step_stim = stimDur/dt;

r_cond1 = r(pop,:,1);
r_cond1 = r_cond1';

r_cond2 = r(pop,:,2);
r_cond2 = r_cond2';

r_cond3 = r(pop,:,3);
r_cond3 = r_cond3';

r_cond4 = r(pop,:,4);
r_cond4 = r_cond4';

r_cond5 = r(pop,:,5);
r_cond5 = r_cond5';

% isINF or NaN
maxVal = max(abs(r_cond4));
last = r(pop,(time/dt)-1,:);
maxDurStim = max(max(r(pop,(stimIn/dt):(time/dt),1)));
low = 0;
% high = 0.013;
if maxVal<100 && sum(isnan(last))==0 && maxDurStim > 0
    
    % maxDurStim = max(max(r(pop,(stimIn/dt):(time/dt),:)));
    % state = getState(r_cond4, time/1000, dt/1000, stimIn/1000); % e.g. 'ON_ON/', 'OFF_ON'
    state = '';
    % for both criteria and plot envelop\
    envMthd = 'peak';
    envWdo = 4000;
    [cond1Up_tmp, ] = envelope(r_cond1(step_stimIn+1:step_stimIn+step_stim+1),envWdo,envMthd);
    [cond2Up_tmp, ] = envelope(r_cond2(step_stimIn+1:step_stimIn+step_stim+1),envWdo,envMthd);
    [cond3Up_tmp, ] = envelope(r_cond3(step_stimIn+1:step_stimIn+step_stim+1),envWdo,envMthd);
    [cond4Up_tmp, ] = envelope(r_cond4(step_stimIn+1:step_stimIn+step_stim+1),envWdo,envMthd);
    [cond5Up_tmp, ] = envelope(r_cond5(step_stimIn+1:step_stimIn+step_stim+1),envWdo,envMthd);
    [criteria,] = asCriteria(cond1Up_tmp, cond2Up_tmp, cond3Up_tmp, cond4Up_tmp, cond5Up_tmp,r_cond4(180000:200000,1),...
        maxDurStim, Delta_e, Delta_i, time);
    disp(criteria);
%%
    figure('visible','on');
%     rectangle('Position',[stimIn 0.00005+lower stimDur upper],'FaceColor','#F5F5F5', ...
%         'EdgeColor','#F5F5F5','LineWidth',1);
%     hold on
    plot(timeax,r_cond1,'Color','#0072BD');
    hold on
    plot(timeax,r_cond2,'Color','#D95319');
    plot(timeax,r_cond3,'Color','#EDB120');
    plot(timeax,r_cond4,'Color','#7E2F8E');
    plot(timeax,r_cond5,'Color','#77AC30');

    title(popName(pop) + " at \Delta_{E}=" + num2str(Delta_e) +...
        ", \Delta_{I}=" + num2str(Delta_i) + ", I_{attn}=" + num2str(Iattn));
    axis([0 time low maxDurStim*1.1]);
    xlabel("Time (ms)");
    ylabel("Firing rate (Hz)");
    legend('Cond1','Cond2','Cond3','Cond4','Cond5','Location','southeast');
    filename = append(num2str(Delta_e),'_',num2str(Delta_i),'_',num2str(Iattn),'.png');
    location = append('tryOneFigure/',filename);
    saveas(gcf, location);

    %% plot raw one by one
    figure('visible','on');
    tiledlayout(5,1)
    ax1 = nexttile;
    plot(timeax,r_cond1,'Color','#0072BD');
    ax2 = nexttile;
    plot(timeax,r_cond2,'Color','#D95319');
    ax3 = nexttile;
    plot(timeax,r_cond3,'Color','#EDB120');
    ax4 = nexttile;
    plot(timeax,r_cond4,'Color','#7E2F8E');
    ax5 = nexttile;
    plot(timeax,r_cond5,'Color','#77AC30');

    linkaxes([ax1 ax2 ax3 ax4 ax5],'xy');
    ax1.YLim = [low maxDurStim*1.1];
    filename = append('Each_',num2str(Delta_e),'_',num2str(Delta_i),'_',num2str(Iattn),'.png');
    location = append('tryOneFigure/',filename);
    saveas(gcf, location);

    %% envelop only during stimulus
    cond1Up = cat(1, r_cond1(1:step_stimIn), cond1Up_tmp); %, r_cond1(step_stimIn+step_stim+comp+1:length(r_cond1)));
    cond2Up = cat(1, r_cond2(1:step_stimIn), cond2Up_tmp); % , r_cond2(step_stimIn+step_stim+comp+1:length(r_cond1)));
    cond3Up = cat(1, r_cond3(1:step_stimIn), cond3Up_tmp); % , r_cond3(step_stimIn+step_stim+comp+1:length(r_cond1)));
    cond4Up = cat(1, r_cond4(1:step_stimIn), cond4Up_tmp); % , r_cond4(step_stimIn+step_stim+comp+1:length(r_cond1)));
    cond5Up = cat(1, r_cond5(1:step_stimIn), cond5Up_tmp); % , r_cond5(step_stimIn+step_stim+comp+1:length(r_cond1)));

    figure('visible','on');
%     rectangle('Position',[stimIn 0.00005+lower stimDur upper],'FaceColor','#F5F5F5', ...
%         'EdgeColor','#F5F5F5','LineWidth',1);
%     hold on
    plot(timeax,cond1Up,'Color','#0072BD');
    hold on
    plot(timeax,cond2Up,'Color','#D95319');
    plot(timeax,cond3Up,'Color','#EDB120');
    plot(timeax,cond4Up,'Color','#7E2F8E');
    plot(timeax,cond5Up,'Color','#77AC30');

    title("Envelope of " + popName(pop) + " at \Delta_{E}=" + num2str(Delta_e) +...
        ", \Delta_{I}=" + num2str(Delta_i) + ", I_{attn}=" + num2str(Iattn));
    axis([0 time low maxDurStim*1.1]);
    xlabel("Time (ms)");
    ylabel("Firing rate (Hz)");
    legend('Cond1','Cond2','Cond3','Cond4','Cond5','Location','southeast');
    filename = append('env_',num2str(Delta_e),'_',num2str(Delta_i),'_',num2str(Iattn),'.png');
    location = append('tryOneFigure/',filename);
    saveas(gcf, location);
    
end
disp(etime(clock, initime));
