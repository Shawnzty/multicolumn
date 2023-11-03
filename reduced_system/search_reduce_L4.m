% parameter search in 2D space
% clear;
% close all;
% clc;
initime = clock;

addpath('..\funcs');

%% changeable parameter settings
Delta_e_start = 0; % cannot equal to 0
Delta_e_end = 0.5; % can equal to 0.5
Delta_e_steps = 60;

Delta_i_start = 0; % cannot equal to 0
Delta_i_end = 0.05; % can equal to 0.05
Delta_i_steps = 60;

Iattn = 0.02;
% ratio_sens_attn = 0; % 3
alltime = 4000;

% container
psdPeaksSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % XX peaks in psd, e.g. -1-NaN, 5 peaks, 12 peaks
intpsdSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % integral over [second f point, 60], -1-NaN, XX-all power
gammaPSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); %  power in gamma band (25-40Hz), -1-NaN, XX-gamma power
betaPSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); %  power in beta band (12-25Hz), -1-NaN, XX-beta power
meanSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % before, after1 2 3 4 5
envSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6);
osciSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % before and after; -1-NaN, 0-noOsci, 1-hasOsci

% par-9 ok
parfor (Delta_e_n = 1:Delta_e_steps,9) % linspace(0.001,0.5,10)
% for Delta_e_n = 1:Delta_e_steps
    Delta_e = Delta_e_start+ Delta_e_n*(Delta_e_end/Delta_e_steps);

for Delta_i_n = 1:Delta_i_steps % none % changable
    Delta_i = Delta_i_start + Delta_i_n*(Delta_i_end/Delta_i_steps);

% Delta_e = 0.01; Delta_i = 0.001;

close all;
startTime = clock;
disp("Computing -- Delta_e:"+num2str(Delta_e)+", Delta_i:"+num2str(Delta_i)+", Iattn:"+num2str(Iattn));

[r,~,~] = reduce_L46(Delta_e, Delta_i, Iattn, ratio_sens_attn, alltime);
[psdPeaks, intpsd, gammaP, betaP, meanLevel, envLevel, osci] = record(r, alltime);

psdPeaksSheet(Delta_i_n, Delta_e_n,:,:) = psdPeaks;
intpsdSheet(Delta_i_n, Delta_e_n,:,:) = intpsd;
gammaPSheet(Delta_i_n, Delta_e_n,:,:) = gammaP;
betaPSheet(Delta_i_n, Delta_e_n,:,:) = betaP;
meanSheet(Delta_i_n, Delta_e_n,:,:) = meanLevel;
envSheet(Delta_i_n, Delta_e_n,:,:) = envLevel;
osciSheet(Delta_i_n, Delta_e_n,:,:) = osci;

disp(etime(clock, startTime));

end
end

psdPeaksSheet = flip(psdPeaksSheet); intpsdSheet = flip(intpsdSheet);
gammaPSheet = flip(gammaPSheet); betaPSheet = flip(betaPSheet);
envSheet = flip(envSheet); meanSheet = flip(meanSheet);
osciSheet = flip(osciSheet);

% end
filename = append('../../data/','reducedL4_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
    num2str(Delta_i_start),'_',num2str(Delta_i_end), '_', num2str(Iattn), '_ratio_', num2str(ratio_sens_attn), '.mat');
save(filename,'psdPeaksSheet','intpsdSheet','gammaPSheet','betaPSheet','osciSheet','meanSheet','envSheet'); 
disp(etime(clock, initime)/60);
