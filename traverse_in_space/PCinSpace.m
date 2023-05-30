% replacement of PET

clear;
clc;
close all;
initime = clock;
addpath('../funcs');

% get the change of PET in parameter space
Delta_e_start = 0.24; % cannot equal to 0
Delta_e_end = 0.3; % can equal to 0.5
Delta_i_start = 0.027; % cannot equal to 0
Delta_i_end = 0.027; % can equal to 0.5
Delta_steps = 200;

Iattn = 0.02;
time = 4000;
strt_prd = 350001;
end_prd = 400000;

% container
PC = zeros(Delta_steps, 16, 16, 6);
finalR = zeros(Delta_steps, 16, 6);

parfor (n =1:Delta_steps,10)
    startTime = clock;
    Delta_e = Delta_e_start + (n-1)*(Delta_e_end-Delta_e_start)/(Delta_steps-1);
    Delta_i = Delta_i_start + (n-1)*(Delta_i_end-Delta_i_start)/(Delta_steps-1);
    [r,v,g] = once(Delta_e, Delta_i, Iattn, time);
    % [head, tail] = period(r,0);
    % for cond = 1:5
    %     finalR(n,:,cond) = squeeze(r(:,head(cond),cond));
    % end
    finalR(n,:,:) = getLevel(r, strt_prd, end_prd);
    PCC = getPC(v(:,strt_prd:end_prd,:), g(:,:,strt_prd:end_prd,:)); % power in unit of micro watt (\mu W), size: 16*16*time*5
    PC0 = getPC(v(:,50001:100000,:),g(:,:,50001:100000,:));
    PC(n,:,:,:) = cat(3,PC0(:,:,1), PCC);

    disp(etime(clock, startTime));
end

filename = append('../../data/','PC_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
    num2str(Delta_i_start),'_',num2str(Delta_i_end), '_Iattn_', num2str(Iattn), '.mat');
save(filename,'PC','finalR'); 
disp(etime(clock, initime)/60);