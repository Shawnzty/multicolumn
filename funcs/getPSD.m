function [f,P1] = getPSD(sig,maxFreq)
%GETPSD get power spectrum density
% already remove the first freq value
% return f(n), P1(n,conds), n is the linear point of f axis.
Fs = 100000;            % Sampling frequency                    
L = size(sig,1);             % Length of signal

Y = fft(sig);

P2 = abs(Y/L);
P1 = P2(1:ceil(L/2+1),:);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
[~,idx]  = min(abs(f-maxFreq)); idx = idx+1;

f = f(2:idx); 
P1 = P1(2:idx,:);
end

