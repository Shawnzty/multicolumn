addpath('../funcs');

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

[r,~,~] = once(0.2, 0.0095, 0.02, alltime);
[psdPeaks, intpsd, gammaP, betaP, level, osci] = record(r, alltime);

psdPeaksSheet(1, 1,:,:) = psdPeaks;
intpsdSheet(1, 1,:,:) = intpsd;
gammaPSheet(1, 1,:,:) = gammaP;
betaPSheet(1, 1,:,:) = betaP;
levelSheet(1, 1,:,:) = level;
osciSheet(1, 1,:,:) = osci;
