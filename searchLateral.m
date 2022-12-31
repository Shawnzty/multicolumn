clear;
close all;
clc;
initime = clock;

addpath('funcs');

%% changeable parameter settings
delta_e_start = 0; % cannot equal to 0
delta_e_end = 0.5; % can equal to 0.5
delta_e_steps = 100;

delta_i_start = 0; % cannot equal to 0
delta_i_end = 0.05; % can equal to 0.05
delta_i_steps = 100;

Iattn = 0.02;

alltime = 4000;

% container
lateralSheet = zeros(delta_e_steps, delta_i_steps,5); % -1-NaN, 0-disagree, 1-agree
orderSheet= zeros(delta_e_steps, delta_i_steps); % -1-NaN, 0-disagree, 1-agree
gammaSheet = zeros(delta_e_steps, delta_i_steps,5); % -1-NaN, 0-noGamma, XX-frequency
betaSheet = zeros(delta_e_steps, delta_i_steps,5); % -1-NaN, 0-noBeta, XX-frequency
ratioSheet = zeros(delta_e_steps, delta_i_steps,5); % -1-NaN, X-ratio
osciSheet = zeros(delta_e_steps, delta_i_steps,5,2); % -1-NaN, 0-noOsci, 1-hasOsci; before and after


parfor Delta_e_n = 1:delta_e_steps % linspace(0.001,0.5,10) % 0.28 % changable
    Delta_e = delta_e_start+ Delta_e_n*(delta_e_end/delta_e_steps);

for Delta_i_n = 1:delta_i_steps % none % changable
    Delta_i = delta_i_start + Delta_i_n*(delta_i_end/delta_i_steps);

close all;
startTime = clock;
disp("Computing -- Delta_e:"+num2str(Delta_e)+", Delta_i:"+num2str(Delta_i)+", Iattn:"+num2str(Iattn));

[r,v,g] = once(Delta_e, Delta_i, Iattn, alltime);
[lateral, order, gamma, beta, ratio] = judge(r, v, g, Delta_e, Delta_i, Iattn, alltime);
lateralSheet(Delta_e_n, Delta_i_n,:) = lateral;
orderSheet(Delta_e_n, Delta_i_n) = order;
gammaSheet(Delta_e_n, Delta_i_n,:) = gamma;
betaSheet(Delta_e_n, Delta_i_n,:) = beta;
ratioSheet(Delta_e_n, Delta_i_n) = ratio;
osciSheet(Delta_e_n, Delta_i_n,:,:) = osci;

disp(etime(clock, startTime));
end
end
% end
filename = append('lateral_',num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',...
    num2str(Delta_i_start),'_',num2str(Delta_i_end), '_Iattn_', num2str(Iattn), '.mat');
save(filename,'lateralSheet','orderSheet','gammaSheet','betaSheet','ratioSheet'); 
disp(etime(clock, initime)/60);
