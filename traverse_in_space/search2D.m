% 20230608 parameter search in 2D space
clear;
close all;
clc;
initime = clock;

addpath('..\funcs');

%% changeable parameter settings
Delta_e_start = 0; % cannot equal to 0
Delta_e_end = 0.5; % can equal to 0.5
Delta_e_steps = 200;

Delta_i_start = 0; % cannot equal to 0
Delta_i_end = 0.05; % can equal to 0.05
Delta_i_steps = 200;

Iattn = 0.02;

alltime = 4000;

% container
psdPeaksSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % XX peaks in psd, e.g. -1-NaN, 5 peaks, 12 peaks
intpsdSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % integral over [second f point, 60], -1-NaN, XX-all power
gammaPSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); %  power in gamma band (25-40Hz), -1-NaN, XX-gamma power
betaPSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); %  power in beta band (12-25Hz), -1-NaN, XX-beta power
levelSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % before, after1 2 3 4 5
osciSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % before and after; -1-NaN, 0-noOsci, 1-hasOsci

% par-9 ok
parfor (Delta_e_n = 1:Delta_e_steps,16) % linspace(0.001,0.5,10)
    Delta_e = Delta_e_start+ Delta_e_n*(Delta_e_end/Delta_e_steps);

for Delta_i_n = 1:Delta_i_steps % none % changable
    Delta_i = Delta_i_start + Delta_i_n*(Delta_i_end/Delta_i_steps);

% Delta_e = 0.01; Delta_i = 0.001;

close all;
startTime = clock;
disp("Computing -- Delta_e:"+num2str(Delta_e)+", Delta_i:"+num2str(Delta_i)+", Iattn:"+num2str(Iattn));

[r,~,~] = once(Delta_e, Delta_i, Iattn, alltime);
[psdPeaks, intpsd, gammaP, betaP, level, osci] = record(r, alltime);

psdPeaksSheet(Delta_i_n, Delta_e_n,:,:) = psdPeaks;
intpsdSheet(Delta_i_n, Delta_e_n,:,:) = intpsd;
gammaPSheet(Delta_i_n, Delta_e_n,:,:) = gammaP;
betaPSheet(Delta_i_n, Delta_e_n,:,:) = betaP;
levelSheet(Delta_i_n, Delta_e_n,:,:) = level;
osciSheet(Delta_i_n, Delta_e_n,:,:) = osci;

disp(etime(clock, startTime));

end
end

psdPeaksSheet = flip(psdPeaksSheet); intpsdSheet = flip(intpsdSheet);
gammaPSheet = flip(gammaPSheet); betaPSheet = flip(betaPSheet);
levelSheet = flip(levelSheet); osciSheet = flip(osciSheet);
 
% end
filename = append('../../data/','allpsd_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
    num2str(Delta_i_start),'_',num2str(Delta_i_end), '_Iattn_', num2str(Iattn), '.mat');
save(filename,'psdPeaksSheet','intpsdSheet','gammaPSheet','betaPSheet','osciSheet','levelSheet'); 
disp(etime(clock, initime)/60);
