addpath('../funcs');
strt_prd = 350001; end_prd = 400000;

[r, v, g] = once(0.2, 0.02, 0.02, 4000);

[powerR, centerfreqR, powerIntR] = getPowerFreq(r, strt_prd, end_prd, 20, 40);

integralRC = squeeze(sum(r(:,strt_prd:end_prd,:),2));
integralR0 = squeeze(sum(r(:,50001:100000,:),2));
integralR = cat(2,integralR0(:,1), integralRC);