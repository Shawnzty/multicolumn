function [lateral, order, gamma, beta, ratio, osci, level] = judge(r, v, g, allTime)
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
lateral = -1*ones(5,1); order = -1; gamma = -1*ones(5,1);
beta = -1*ones(5,1); ratio = -1; osci = -1*ones(2,5);
level = -1*ones(6,1);

dt = 0.01;
stimIn = 1000;
step_stimIn = stimIn/dt;

r_cond1 = r(5,end-100000:end,1)';
r_cond2 = r(5,end-100000:end,2)';
r_cond3 = r(5,end-100000:end,3)';
r_cond4 = r(5,end-100000:end,4)';
r_cond5 = r(5,end-100000:end,5)';

maxVal = max(r_cond4);
last = r(5,(allTime/dt)-1,:);
maxDurStim = max(max(r(5,(stimIn/dt):(allTime/dt),1)));

if maxVal<100 && sum(isnan(last))==0 && maxDurStim > 0
    % lateral pathway % [12>21 12<21 12=po21 12>21 12<21] "12>21" = 1
    prd = 100000;
    PET = getPET(v(:,end-prd:end,:),g(:,:,end-prd:end,:)); 
    oneTwo = squeeze(PET(10,1,:));
    twoOne = squeeze(PET(2,9,:));
    lateral = [oneTwo(1)>twoOne(1) oneTwo(2)<twoOne(2)...
        abs(oneTwo(3)-twoOne(3))<0.001 oneTwo(4)>twoOne(4) oneTwo(5)<twoOne(5)];

    % is oscilating?
    bf1 = step_stimIn-10; bf2 = step_stimIn-8;
    beforeOsci = [r(5,bf1,1) == r(5,bf2,1) r(5,bf1,2) == r(5,bf2,2) ...
        r(5,bf1,3) == r(5,bf2,3) r(5,bf1,4) == r(5,bf2,4) ...
        r(5,bf1,5) == r(5,bf2,5)];
    afterOsci = [r_cond1(end-10) == r_cond1(end-8) r_cond2(end-10) == r_cond2(end-8) ...
        r_cond3(end-10) == r_cond3(end-8) r_cond4(end-10) == r_cond4(end-8) ...
        r_cond5(end-10) == r_cond5(end-8)];
    osci(1,:) = ~beforeOsci; osci(2,:) = ~afterOsci;

    % gamma and beta
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

    % level
    [r_cond0, ] = envelope(r(5,1:100000,1)',envWdo,envMthd);
    cond0Mean = mean(r_cond0(end-10000:end-envWdo));
    cond2Mean = mean(r_cond2); cond5Mean = mean(r_cond5);
    level = [cond0Mean cond1Mean cond2Mean cond3Mean cond4Mean cond5Mean];

    % order
    criteria1 = sum(r_cond1<r_cond3)==0 && sum(r_cond1<r_cond5)==0 && sum(r_cond4<r_cond3)==0 && sum(r_cond4<r_cond5)==0;
    criteria2 = sum(r_cond1<r_cond2)==0 && sum(r_cond3<r_cond2)==0 && sum(r_cond4<r_cond2)==0 && sum(r_cond5<r_cond2)==0;
    if criteria1 && criteria2
        order = 1;
    else
        order = 0;
    end

end

