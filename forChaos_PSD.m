clear;
close all;
clc;
initime = clock;
addpath('funcs');


Delta_e = 0.15; % 0.3
Delta_i = 0.04; % 0.04
Iattn = 0.02;

time = 4000;
maxFreq = 60;

[r,v,~] = once(Delta_e, Delta_i, Iattn, time);

%% fft
sigC = squeeze(r(5,300000:end,:));
sig0 = squeeze(r(5,50000:100000,1)); 
% sig = sig';

Fs = 100000;            % Sampling frequency                    
L = length(sigC);             % Length of signal

Y = fft(sigC);
P2 = abs(Y/L);
P1 = P2(1:ceil(L/2+1),:);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
[~,idx]  = min(abs(f-maxFreq)); idx = idx+1;
f = f(2:idx); P1 = P1(2:idx,:);

%% pks
pksNum = zeros(6,1);
for i = 1:5
[pks,~] = findpeaks(P1(:,i));
pksNum(i+1) = length(pks);
end

% pks for original
Fs = 100000;            % Sampling frequency                    
L = length(sig0);             % Length of signal

Y = fft(sig0);
P2 = abs(Y/L);
P1 = P2(1:ceil(L/2+1));
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
[~,idx]  = min(abs(f-maxFreq)); idx = idx+1;
f = f(2:idx); P1 = P1(2:idx);

[pks,locs] = findpeaks(P1);
pksNum(1) = length(pks);

%% plot
plot(f,P1);
% findpeaks(P1);
xlim([0 maxFreq]);
title("Amplitude Spectrum: \Delta_{E}=" + num2str(Delta_e) +...
    ", \Delta_{I}=" + num2str(Delta_i) + ", I_{attn}=" + num2str(Iattn) + ", pks=" + num2str(length(locs)));
xlabel("f (Hz)");
ylabel("|P1(f)|");

filename = append('PSD_',num2str(Delta_e),'_',num2str(Delta_i),'_',num2str(Iattn),'.png');
location = append('tryOneFigure/',filename);
saveas(gcf, location);