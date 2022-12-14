function isPloted = plotTC(r,pop, Iattn, Delta_e,Delta_i, rawORenv, envWdo)
%UNTITLED plot time course of the dynamics
%   parameters include r,v,g
%   save or not save, raw data or envelope
%   which population
%   rawOrEnv: 0 for raw data, 1 for envelope, 2 for both

popName = {'1L23e','1L23i','1L4e','1L4i','1L5e','1L5i','1L6e','1L6i', ...
    '2L23e','2L23i','2L4e','2L4i','2L5e','2L5i','2L6e','2L6i'};

dt = 0.01;
time = 2000;
timeax = 0:dt:time;
timeax = timeax';
stimIn = 1000;
stimDur = 1000;
step_stimIn = stimIn/dt;
step_stim = stimDur/dt;

r_cond1 = r(pop,:,1)';
r_cond2 = r(pop,:,2)';
r_cond3 = r(pop,:,3)';
r_cond4 = r(pop,:,4)';
r_cond5 = r(pop,:,5)';

% isINF or NaN
maxVal = max(r_cond4);
last = r(pop,(time/dt)-1,:);
maxDurStim = max(max(r(pop,(stimIn/dt):(time/dt),1)));
if maxVal<100 && sum(isnan(last))==0 && maxDurStim > 0
    
    % maxDurStim = max(max(r(pop,(stimIn/dt):(time/dt),:)));
    % state = getState(r_cond4, time/1000, dt/1000, stimIn/1000); % e.g. 'ON_ON/', 'OFF_ON'
    % for both criteria and plot envelop\
    envMthd = 'peak';
    [cond1Up_tmp, ] = envelope(r_cond1(step_stimIn+1:step_stimIn+step_stim+1),envWdo,envMthd);
    [cond2Up_tmp, ] = envelope(r_cond2(step_stimIn+1:step_stimIn+step_stim+1),envWdo,envMthd);
    [cond3Up_tmp, ] = envelope(r_cond3(step_stimIn+1:step_stimIn+step_stim+1),envWdo,envMthd);
    [cond4Up_tmp, ] = envelope(r_cond4(step_stimIn+1:step_stimIn+step_stim+1),envWdo,envMthd);
    [cond5Up_tmp, ] = envelope(r_cond5(step_stimIn+1:step_stimIn+step_stim+1),envWdo,envMthd);
    [location, location_env] = asCriteria(cond1Up_tmp, cond2Up_tmp, cond3Up_tmp, cond4Up_tmp, cond5Up_tmp,...
        r_cond4(180000:200000,1), maxDurStim, Delta_e, Delta_i, Iattn);

    if rawORenv ~= 1
    figure('visible','off');
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
    axis([0 2000 0 maxDurStim*1.1]);
    xlabel("Time (ms)");
    ylabel("Firing rate (Hz)");
    legend('Cond1','Cond2','Cond3','Cond4','Cond5','Location','northwest');
    % disp(location);
    saveas(gcf, location);
    end

    if rawORenv ~= 0
    
    % envelop only during stimulus
    cond1Up = cat(1, r_cond1(1:step_stimIn), cond1Up_tmp); %, r_cond1(step_stimIn+step_stim+comp+1:length(r_cond1)));
    cond2Up = cat(1, r_cond2(1:step_stimIn), cond2Up_tmp); % , r_cond2(step_stimIn+step_stim+comp+1:length(r_cond1)));
    cond3Up = cat(1, r_cond3(1:step_stimIn), cond3Up_tmp); % , r_cond3(step_stimIn+step_stim+comp+1:length(r_cond1)));
    cond4Up = cat(1, r_cond4(1:step_stimIn), cond4Up_tmp); % , r_cond4(step_stimIn+step_stim+comp+1:length(r_cond1)));
    cond5Up = cat(1, r_cond5(1:step_stimIn), cond5Up_tmp); % , r_cond5(step_stimIn+step_stim+comp+1:length(r_cond1)));

    figure('visible','off');
%     rectangle('Position',[stimIn 0.00005+lower stimDur upper],'FaceColor','#F5F5F5', ...
%         'EdgeColor','#F5F5F5','LineWidth',1);
%     hold on
    plot(timeax,cond1Up,'Color','#0072BD');
    hold on
    plot(timeax,cond2Up,'Color','#D95319');
    plot(timeax,cond3Up,'Color','#EDB120');
    plot(timeax,cond4Up,'Color','#7E2F8E');
    plot(timeax,cond5Up,'Color','#77AC30');

%     % plot by findpeak
%     [pks1,locs1] = findpeaks(r_cond1(step_stimIn+1:step_stimOut+1));
%     [pks2,locs2] = findpeaks(r_cond2(step_stimIn+1:step_stimOut+1));
%     [pks3,locs3] = findpeaks(r_cond3(step_stimIn+1:step_stimOut+1));
%     [pks4,locs4] = findpeaks(r_cond4(step_stimIn+1:step_stimOut+1));
%     [pks5,locs5] = findpeaks(r_cond5(step_stimIn+1:step_stimOut+1));
%     a = [timeax(1:step_stimIn), r_cond1(1:step_stimIn)];
%     b = cat(1, a, [locs1, pks1]);

    title("Envelope of " + popName(pop) + " at \Delta_{E}=" + num2str(Delta_e) +...
        ", \Delta_{I}=" + num2str(Delta_i) + ", I_{attn}=" + num2str(Iattn));
    axis([0 2000 0 maxDurStim*1.1]);
    xlabel("Time (ms)");
    ylabel("Firing rate (Hz)");
    legend('Cond1','Cond2','Cond3','Cond4','Cond5','Location','northwest');
    % disp(location);
    saveas(gcf, location_env);
    end
    
end
isPloted = 1;
end

