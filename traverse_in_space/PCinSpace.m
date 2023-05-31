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
finalR = zeros(Delta_steps, 16, 6); % level of firing rate
powerR = zeros(Delta_steps, 16, 6); % power of gamma band frequency
centerfreqR = zeros(Delta_steps,16, 6); % center frequency of gamma oscillation
powerIntR = zeros(Delta_steps,16, 6); % integral of the power of gamma band frequency
integralR = zeros(Delta_steps,16, 6); % integral of firing rate over time

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

    PCC = getPC(v(:,strt_prd:end_prd,:), g(:,:,strt_prd:end_prd,:)); % power in unit of micro watt (\mu W), size: 16*16*time*5
    PC0 = getPC(v(:,50001:100000,:),g(:,:,50001:100000,:));
    PC(n,:,:,:) = cat(3,PC0(:,:,1), PCC);

    disp(etime(clock, startTime));
end

filename = append('../../data/','PC_power_integral_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
    num2str(Delta_i_start),'_',num2str(Delta_i_end), '_Iattn_', num2str(Iattn), '.mat');
save(filename,'PC','finalR','powerR','centerfreqR','powerIntR','integralR'); 
disp(etime(clock, initime)/60);