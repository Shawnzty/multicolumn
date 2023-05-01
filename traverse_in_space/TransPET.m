clear;
clc;
close all;
initime = clock;
addpath('..\funcs');


% get the change of PET in parameter space
Delta_e_start = 0.32; % larger than
Delta_e_end = 0.32; % equal or smaller than
Delta_i_start = 0.024; % larger than
Delta_i_end = 0.044; % equal or smaller than
Delta_steps = 100;

Iattn = 0.02;
time = 4000;
strt_prd = 300001;
end_prd = 400000;

% folder name
folder = append('../../data/tPET_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
    num2str(Delta_i_start),'_',num2str(Delta_i_end), '_Iattn_', num2str(Iattn));
mkdir(folder);

% container
tPET = zeros(16, 16, end_prd-strt_prd+1,5);
fr = zeros(16, end_prd-strt_prd+1,5);

% Parallel computing
% parpool('Processes',2)
for n = 1:Delta_steps
    startTime = clock;

    disp(strcat(num2str(n), '/', num2str(Delta_steps)));
    Delta_e = Delta_e_start + (n-1)*(Delta_e_end-Delta_e_start)/(Delta_steps-1);
    Delta_i = Delta_i_start + (n-1)*(Delta_i_end-Delta_i_start)/(Delta_steps-1);
    [r,v,g] = once(Delta_e, Delta_i, Iattn, time);
    tPET = getTransPET(v(:,strt_prd:end_prd,:), g(:,:,strt_prd:end_prd,:)); % power in unit of micro watt (\mu W), size: 16*16*time*5
    fr = r(:,strt_prd:end_prd,:);

    filename = append(folder,'\',num2str(n), '.mat');
    save(filename, 'tPET','fr', '-v7.3');
    disp(etime(clock, startTime));
end

% filename = append('../../data/tPET_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
%     num2str(Delta_i_start),'_',num2str(Delta_i_end), '_Iattn_', num2str(Iattn), '.mat');
% save(filename, 'tPET','fr', '-v7.3');
disp(etime(clock, initime)/60);
