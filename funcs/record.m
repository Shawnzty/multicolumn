function [psdPeaks, intpsd, gammaP, betaP, level, osci] = record(r, allTime)
%JUDGE give property of the parameter setting
%   Detailed explanation goes here
% lateralSheet = zeros(delta_e_steps, delta_i_steps,5); % -1-NaN, 0-disagree, 1-agree
% orderSheet= zeros(delta_e_steps, delta_i_steps); % -1-NaN, 0-disagree, 1-agree
% gammaSheet = zeros(delta_e_steps, delta_i_steps,5); % -1-NaN, 0-noGamma, XX-frequency
% betaSheet = zeros(delta_e_steps, delta_i_steps,5); % -1-NaN, 0-noBeta, XX-frequency
% ratioSheet = zeros(delta_e_steps, delta_i_steps); % -1-NaN, X-ratio
% osciSheet = zeros(delta_e_steps, delta_i_steps,2,5); % before and after; -1-NaN, 0-noOsci, 1-hasOsci
% levelSheet = zeros();

% default value for output
psdPeaks = -1*ones(16,6); intpsd = -1*ones(16,6); gammaP = -1*ones(16,6);
betaP = -1*ones(16,6); osci = -1*ones(16,6); level = -1*ones(16,6);

dt = 0.01;
stimIn = 1000;
maxFreq = 60;

r_cond4 = r(5,end-100000:end,4)';

maxVal = max(r_cond4);
last = r(5,(allTime/dt)-1,:);
maxDurStim = max(max(r(5,(stimIn/dt):(allTime/dt),1)));

if maxVal<100 && sum(isnan(last))==0 && maxDurStim > 0
for pop = 1:16

r_cond0 = r(pop,50000:99999,1)';
r_cond1 = r(pop,end-50000:end,1)';
r_cond2 = r(pop,end-50000:end,2)';
r_cond3 = r(pop,end-50000:end,3)';
r_cond4 = r(pop,end-50000:end,4)';
r_cond5 = r(pop,end-50000:end,5)';

    % is oscilating?
    beforeOsci = r_cond0(end-10) == r_cond0(end-8);
    afterOsci = [r_cond1(end-10) == r_cond1(end-8) r_cond2(end-10) == r_cond2(end-8) ...
        r_cond3(end-10) == r_cond3(end-8) r_cond4(end-10) == r_cond4(end-8) ...
        r_cond5(end-10) == r_cond5(end-8)];
    osci(1) = beforeOsci; osci(2:end) = afterOsci;
    
    % level
    envMthd = 'peak'; envWdo = 4000;
    [r_cond0_env, ] = envelope(r_cond0,envWdo,envMthd);
    [r_cond1_env, ] = envelope(r_cond1,envWdo,envMthd);
    [r_cond2_env, ] = envelope(r_cond2,envWdo,envMthd);
    [r_cond3_env, ] = envelope(r_cond3,envWdo,envMthd);
    [r_cond4_env, ] = envelope(r_cond4,envWdo,envMthd);
    [r_cond5_env, ] = envelope(r_cond5,envWdo,envMthd);
    r_cond0_env = r_cond0_env(end-30000:end-envWdo);
    r_cond1_env = r_cond1_env(end-30000:end-envWdo);
    r_cond2_env = r_cond2_env(end-30000:end-envWdo);
    r_cond3_env = r_cond3_env(end-30000:end-envWdo);
    r_cond4_env = r_cond4_env(end-30000:end-envWdo);
    r_cond5_env = r_cond5_env(end-30000:end-envWdo);
    
    
    cond0Mean = mean(r_cond0_env); cond1Mean = mean(r_cond1_env);
    cond2Mean = mean(r_cond2_env); cond3Mean = mean(r_cond3_env);
    cond4Mean = mean(r_cond4_env); cond5Mean = mean(r_cond5_env);
    level = [cond0Mean cond1Mean cond2Mean cond3Mean cond4Mean cond5Mean];

    % psd
    r_forpsd = [r_cond0; r_cond1; r_cond2; r_cond3; r_cond4; r_cond5];
    [f, P1] = getPSD(r_forpsd, 60);
    
    % psdPeaks

    % intpsd
    


end
end

