function [powerR, centerfreqR, powerIntR] = getPowerFreq(r, strt_prd, end_prd, band_from, band_to)
%GETPOWERFREQ get both center frequency and the power of it
%   Detailed explanation goes here

powerR = zeros(16,6);
centerfreqR = zeros(16,6);
powerIntR = zeros(16,6);
maxFreq = 100; % max frequency kept

for pop = 1:16
sig = r(pop,50001:100000,1)';
[f,P1] = getPSD(sig,maxFreq);

f_idx = find(f>=band_from & f<=band_to);
P_f = P1(f_idx,:);
[powerR(pop,1), powerR_fidx] = max(P_f);
centerfreqR(pop,1) = f(f_idx(powerR_fidx));
powerIntR(pop,1) = sum(P_f);

sig = squeeze(r(pop,strt_prd:end_prd,:));
maxFreq = 100; % max frequency kept
[f,P1] = getPSD(sig,maxFreq);

f_idx = find(f>=band_from & f<=band_to);
P_f = P1(f_idx,:);
[powerR_val, powerR_fidx] = max(P_f);
powerR(pop,2:6) = powerR_val;
centerfreqR(pop,2:6) = f(f_idx(powerR_fidx));
powerIntR(pop,2:6) = sum(P_f,1);

end
end

