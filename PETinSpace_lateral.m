clear;
clc;
close all;
initime = clock;
addpath('funcs');

% get the change of PET in parameter space
Delta_e_start = 0.3; % cannot equal to 0
Delta_e_end = 0.3; % can equal to 0.5
Delta_i_start = 0.014; % cannot equal to 0
Delta_i_end = 0.035; % can equal to 0.5
Delta_steps = 201;

Iattn = 0.02;
time = 10000;
strt_prd = 400001;
end_prd = 1000000;

% container
PETA = zeros(Delta_steps, 16, 16, 5);
PETO = zeros(Delta_steps, 16, 16, 5);
finalR = zeros(Delta_steps, 16, 5);

for n = 1:Delta_steps
    startTime = clock;
    Delta_e = Delta_e_start + (n-1)*(Delta_e_end-Delta_e_start)/(Delta_steps-1);
    Delta_i = Delta_i_start + (n-1)*(Delta_i_end-Delta_i_start)/(Delta_steps-1);
    [r,v,g] = once(Delta_e, Delta_i, Iattn, time);
    PETA(n,:,:,:) = getPET(v(:,strt_prd:end_prd,:), g(:,:,strt_prd:end_prd,:)); % power in unit of micro watt (\mu W), size: 16*16*time*5
    [head, tail] = period(r,0);
    for cond = 1:5
        dur = (tail(cond) - head(cond))*0.001*0.01;
        tmp = getPET(v(:,head(cond):tail(cond),:), g(:,:,head(cond):tail(cond),:));
        PETO(n,:,:,cond) =  tmp(:,:,cond) ./ dur;
        finalR(n,:,cond) = squeeze(r(:,head(cond),cond));
    end
    disp(etime(clock, startTime));
end

filename = append('lateral_PET_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
    num2str(Delta_i_start),'_',num2str(Delta_i_end), '_Iattn_', num2str(Iattn), '.mat');
save(filename,'PETA','PETO','finalR'); 
disp(etime(clock, initime)/60);