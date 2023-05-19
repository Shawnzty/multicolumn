function [freqs, powers] = psdPeak(signal, maxFreq)
% return two list: freqs and power. freqs contains the freqency of the
% peak. power contains the psd value of the peak.
% signal is time * 5 conditions

[f, P1] = getPSD(signal, maxFreq);
for i = 1:5
[pks,locs] = findpeaks(P1(:,i));
powers(i,:) = pks;
freqs(i,:) = f(locs);
end

end

