clear;
close all;
clc;
initime = clock;

addpath('funcs');

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
lateralSheet = zeros(Delta_e_steps, Delta_i_steps,5); % -1-NaN, 0-disagree, 1-agree
orderSheet= zeros(Delta_e_steps, Delta_i_steps); % -1-NaN, 0-disagree, 1-agree
gammaSheet = zeros(Delta_e_steps, Delta_i_steps,5); % -1-NaN, 0-noGamma, XX-frequency
betaSheet = zeros(Delta_e_steps, Delta_i_steps,5); % -1-NaN, 0-noBeta, XX-frequency
ratioSheet = zeros(Delta_e_steps, Delta_i_steps); % -1-NaN, X-ratio
osciSheet = zeros(Delta_e_steps, Delta_i_steps,2,5); % before and after; -1-NaN, 0-noOsci, 1-hasOsci
levelSheet = zeros(Delta_e_steps, Delta_i_steps, 6); % before, after1 2 3 4 5

parfor Delta_e_n = 1:Delta_e_steps % linspace(0.001,0.5,10) % 0.28 % changable
    Delta_e = Delta_e_start+ Delta_e_n*(Delta_e_end/Delta_e_steps);

for Delta_i_n = 1:Delta_i_steps % none % changable
    Delta_i = Delta_i_start + Delta_i_n*(Delta_i_end/Delta_i_steps);

% Delta_e = 0.01; Delta_i = 0.001;

close all;
startTime = clock;
disp("Computing -- Delta_e:"+num2str(Delta_e)+", Delta_i:"+num2str(Delta_i)+", Iattn:"+num2str(Iattn));

[r,v,g] = once(Delta_e, Delta_i, Iattn, alltime);
[lateral, order, gamma, beta, ratio, osci, level] = judge(r, v, g, alltime);

lateralSheet(Delta_i_n, Delta_e_n,:) = lateral;
orderSheet(Delta_i_n, Delta_e_n) = order;
gammaSheet(Delta_i_n, Delta_e_n,:) = gamma;
betaSheet(Delta_i_n, Delta_e_n,:) = beta;
ratioSheet(Delta_i_n, Delta_e_n) = ratio;
osciSheet(Delta_i_n, Delta_e_n,:,:) = osci;
levelSheet(Delta_i_n, Delta_e_n,:,:) = level;
disp(etime(clock, startTime));
end
end
lateralSheet = flip(lateralSheet); orderSheet = flip(orderSheet);
gammaSheet = flip(gammaSheet); betaSheet = flip(betaSheet);
ratioSheet = flip(ratioSheet); osciSheet = flip(osciSheet);
% end
filename = append('lateral_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
    num2str(Delta_i_start),'_',num2str(Delta_i_end), '_Iattn_', num2str(Iattn), '.mat');
save(filename,'lateralSheet','orderSheet','gammaSheet','betaSheet','ratioSheet','osciSheet','levelSheet'); 
disp(etime(clock, initime)/60);
