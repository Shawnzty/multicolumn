% replacement of PET

clear;
clc;
close all;
initime = clock;
addpath('../funcs');

% get the change of PET in parameter space
Delta_e_start = 0.3; % cannot equal to 0
Delta_e_end = 0.3; % can equal to 0.5
Delta_i_start = 0.027; % cannot equal to 0
Delta_i_end = 0.032; % can equal to 0.5
Delta_steps = 200;

Iattn = 0.02;
time = 4000;
strt_prd = 350001;
end_prd = 400000;


% container
PC = zeros(Delta_steps, 16, 16, 6);
intCyclePC = zeros(Delta_steps, 16, 16, 6); % integral PC over one oscillation cycle

finalR = zeros(Delta_steps, 16, 6); % level of firing rate
powerR = zeros(Delta_steps, 16, 6); % power of gamma band frequency
centerfreqR = zeros(Delta_steps,16, 6); % center frequency of gamma oscillation
powerIntR = zeros(Delta_steps,16, 6); % integral of the power of gamma band frequency
integralR = zeros(Delta_steps,16, 6); % integral of firing rate over time
intCycleR = zeros(Delta_steps, 16, 6); % integral firing rate over one oscillation cycle

parfor (n = 1:Delta_steps,9)
    startTime = clock;
    Delta_e = Delta_e_start + (n-1)*(Delta_e_end-Delta_e_start)/(Delta_steps-1);
    Delta_i = Delta_i_start + (n-1)*(Delta_i_end-Delta_i_start)/(Delta_steps-1);
    [r,v,g] = once(Delta_e, Delta_i, Iattn, time);

    finalR(n,:,:) = getLevel(r, strt_prd, end_prd);
    [powerR(n,:,:), centerfreqR(n,:,:), powerIntR(n,:,:)] = getPowerFreq(r, strt_prd, end_prd, 20, 40);
    integralRC = squeeze(sum(r(:,strt_prd:end_prd,:),2));
    integralR0 = squeeze(sum(r(:,50001:100000,:),2));
    integralR(n,:,:) = cat(2,integralR0(:,1), integralRC);
    
    [period_begin, period_finish] = getPeriod(r);
    intCycleRC = squeeze(sum(r(:,period_begin:period_finish,:),2));
    intCyclePCC = getIntPC(v(:,period_begin:period_finish,:), g(:,:,period_begin:period_finish,:));
    [period_begin, period_finish] = getPeriod(r(:,50001:100000,:));
    intCycleR0 = squeeze(sum(r(:,period_begin:period_finish,:),2));
    intCyclePC0 = getIntPC(v(:,period_begin:period_finish,:), g(:,:,period_begin:period_finish,:));
    intCycleR(n,:,:) = cat(2,intCycleR0(:,1), intCycleRC);
    intCyclePC(n,:,:,:) = cat(3,intCyclePC0(:,:,1), intCyclePCC);
    
    PCC = getIntPC(v(:,strt_prd:end_prd,:), g(:,:,strt_prd:end_prd,:)); % power in unit of micro watt (\mu W), size: 16*16*time*5
    PC0 = getIntPC(v(:,50001:100000,:),g(:,:,50001:100000,:));
    PC(n,:,:,:) = cat(3,PC0(:,:,1), PCC);

    disp(etime(clock, startTime));
end

filename = append('../../data/','IntCyclePET_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
    num2str(Delta_i_start),'_',num2str(Delta_i_end), '_Iattn_', num2str(Iattn), '.mat');
save(filename,'PC','finalR','powerR','centerfreqR','powerIntR','integralR','intCycleR','intCyclePC'); 
disp(etime(clock, initime)/60);