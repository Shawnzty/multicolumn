function [lateral, order, gamma, beta, ratio, osci] = judge(r, v, g, Delta_e, Delta_i, Iattn, allTime)
%JUDGE give property of the parameter setting
%   Detailed explanation goes here
% lateralSheet = zeros(delta_e_steps, delta_i_steps,5); % 0-NaN, 1-disagree, 2-agree
% orderSheet= zeros(delta_e_steps, delta_i_steps); % 0-INF, 2-disagree, 3-agree
% gammaSheet = zeros(delta_e_steps, delta_i_steps,5); % -1-NaN, 0-noGamma, XX-frequency
% betaSheet = zeros(delta_e_steps, delta_i_steps,5); % -1-NaN, 0-noBeta, XX-frequency
% ratioSheet = zeros(delta_e_steps, delta_i_steps,5); % 0-NaN, X-ratio
% osciSheet = zeros(delta_e_steps, delta_i_steps,5,2); % -1-NaN, 0-noOsci, 1-hasOsci; before and after

% default value for output
lateral = 0; order = 0; gamma = -1;
beta = -1; ratio = 0;

dt = 0.01;
timeax = 0:dt:allTime;
timeax = timeax';
stimIn = 1000;
stimDur = time-stimIn;
step_stimIn = stimIn/dt;
step_stim = stimDur/dt;

r_cond1 = r(5,end-100000:end,1)';
r_cond2 = r(5,end-100000:end,2)';
r_cond3 = r(5,end-100000:end,3)';
r_cond4 = r(5,end-100000:end,4)';
r_cond5 = r(5,end-100000:end,5)';

maxVal = max(r_cond4);
last = r(pop,(allTime/dt)-1,:);
maxDurStim = max(max(r(pop,(stimIn/dt):(allTime/dt),1)));

if maxVal<100 && sum(isnan(last))==0 && maxDurStim > 0
    % lateral pathway
    
    % frequency
    [gamma1, beta1] = getCenterFreq(r_cond1(end-50001:end-1));
    [gamma2, beta2] = getCenterFreq(r_cond2(end-50001:end-1));
    [gamma3, beta3] = getCenterFreq(r_cond3(end-50001:end-1));
    [gamma4, beta4] = getCenterFreq(r_cond4(end-50001:end-1));
    [gamma5, beta5] = getCenterFreq(r_cond5(end-50001:end-1));
    gamma = [gamma1 gamma2 gamma3 gamma4 gamma5];
    beta = [beta1 beta2 beta3 beta4 beta5];
    
        envMthd = 'peak'; envWdo = 4000;
        [r_cond1, ] = envelope(r_cond1,envWdo,envMthd);
        [r_cond2, ] = envelope(r_cond2,envWdo,envMthd);
        [r_cond3, ] = envelope(r_cond3,envWdo,envMthd);
        [r_cond4, ] = envelope(r_cond4,envWdo,envMthd);
        [r_cond5, ] = envelope(r_cond5,envWdo,envMthd);
        r_cond1 = r_cond1(end-30000:end-envWdo);
        r_cond2 = r_cond2(end-30000:end-envWdo);
        r_cond3 = r_cond3(end-30000:end-envWdo);
        r_cond4 = r_cond4(end-30000:end-envWdo);
        r_cond5 = r_cond5(end-30000:end-envWdo);

        % ratio
        cond1Mean = mean(r_cond1);cond3Mean = mean(r_cond3);cond4Mean = mean(r_cond4);
        diff13 = cond1Mean - cond3Mean; diff34 = cond4Mean - cond3Mean;
        ratio = diff34/diff13;

        % order
        criteria1 = sum(r_cond1<r_cond3)==0 && sum(r_cond1<r_cond5)==0 && sum(r_cond4<r_cond3)==0 && sum(r_cond4<r_cond5)==0;
        criteria2 = sum(r_cond1<cond2)==0 && sum(r_cond3<r_cond2)==0 && sum(r_cond4<r_cond2)==0 && sum(r_cond5<r_cond2)==0;
    
        if criteria1 && criteria2
            order = 3;
        else
            order = 2;
        end

    % is oscilating?
    lastOsci = r_cond1(end-10) == r_cond1(end-8) && r_cond2(end-10) == r_cond2(end-8)...
        && r_cond3(end-10) == r_cond3(end-8) && r_cond4(end-10) == r_cond4(end-8)...
        && r_cond5(end-10) == r_cond5(end-8);
    if lastOsci
        order = 1;
    end



end

