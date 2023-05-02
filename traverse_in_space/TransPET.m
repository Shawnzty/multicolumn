clear;
clc;
close all;
initime = clock;
addpath('..\funcs');


% get the change of PET in parameter space
Delta_e_start = 0.22; % larger than
Delta_e_end = 0.42; % equal or smaller than
Delta_i_start = 0.034; % larger than
Delta_i_end = 0.034; % equal or smaller than
Delta_steps = 100;

Iattn = 0.02;
time = 4000;
strt_prd = 350001;
end_prd = 400000;

% folder name
folder = append('../../data/tPET_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
    num2str(Delta_i_start),'_',num2str(Delta_i_end), '_Iattn_', num2str(Iattn));
mkdir(folder);

% container
% tPET = zeros(16, 16, end_prd-strt_prd+1,5);
% fr = zeros(16, end_prd-strt_prd+1,5);

% Parallel computing
% parpool('Processes',2)
%% loop
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
disp("Computation done");
disp(etime(clock, initime)/60);
clearvars tPET fr r v g;

%% Combine tmp data
tPET = zeros(Delta_steps,16,16,end_prd-strt_prd+1,5);
fr = zeros(Delta_steps,16,end_prd-strt_prd+1,5);
for i = 1:100
    filename = append(folder,'/',num2str(i),".mat");
    load_data = load(filename);
    tPET(i,:,:,:,:) = load_data.tPET;
    fr(i,:,:,:) = load_data.fr;
    clearvars load_data;
    % delete filename;
    disp(append(num2str(i), " done"));
end
disp("Saving...")
save(append(folder,".mat"), "tPET", "fr", "-v7.3");
save("Save done.")
