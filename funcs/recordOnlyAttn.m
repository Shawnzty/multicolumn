function [psdPeaks, intpsd, gammaP, betaP, meanLevel, envLevel, osci] = recordOnlyAttn(r, allTime)
% RECORD give property of the parameter setting

% psdPeaksSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % XX peaks in psd, e.g. -1-NaN, 5 peaks, 12 peaks
% intpsdSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % integral over [second f point, 60], -1-NaN, XX-all power
% gammaPSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); %  power in gamma band (25-40Hz), -1-NaN, XX-gamma power
% betaPSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); %  power in beta band (12-25Hz), -1-NaN, XX-beta power
% meanSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % before, after1 2 3 4 5
% envSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6);
% osciSheet = zeros(Delta_e_steps, Delta_i_steps, 16, 6); % before and after; -1-NaN, 0-noOsci, 1-hasOsci



% default value for output
psdPeaks = -1*ones(16,6); intpsd = -1*ones(16,6); gammaP = -1*ones(16,6);
betaP = -1*ones(16,6); osci = -1*ones(16,6); meanLevel = -1*ones(16,6); envLevel = -1*ones(16,6);

dt = 0.01;
stimIn = 1000;
maxFreq = 60;

r_cond4 = r(5,end-100000:end,4)';

maxVal = max(r_cond4);
last = r(5,(allTime/dt)-1,:);
maxDurStim = max(max(r(5,(stimIn/dt):(allTime/dt),1)));

if maxVal<100 && sum(isnan(last))==0 && maxDurStim > 0
for pop = 1:16

r_cond0 = r(pop,49999:99999,1)';
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
    osci(pop, 1) = beforeOsci; osci(pop, 2:end) = afterOsci;
    
    % method 1： envSheet
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
    envLevel(pop,:) = [cond0Mean cond1Mean cond2Mean cond3Mean cond4Mean cond5Mean];

    % method 2: mean
    cond0Mean = mean(r_cond0); cond1Mean = mean(r_cond1);
    cond2Mean = mean(r_cond2); cond3Mean = mean(r_cond3);
    cond4Mean = mean(r_cond4); cond5Mean = mean(r_cond5);
    meanLevel(pop,:) = [cond0Mean cond1Mean cond2Mean cond3Mean cond4Mean cond5Mean];

    % psd
    r_forpsd = cat(2,r_cond0,r_cond1,r_cond2,r_cond3,r_cond4,r_cond5);
    [f, P1] = getPSD(r_forpsd, 60);
    
    % psdPeaks
    for cond = 1:6
    [pks,~] = findpeaks(P1(:,cond));
    psdPeaks(pop,cond) = length(pks);
    end

    % intpsd
    intpsd(pop,:) = sum(P1,1)*(f(3)-f(2));

    % gammaP
    gammaP(pop,:) = sum(P1(f>25 & f<40,:), 1);

    % betaP
    betaP(pop,:) = sum(P1(f>12 & f<25,:), 1);

end
end

