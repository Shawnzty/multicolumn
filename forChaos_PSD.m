clear;
close all;
clc;
initime = clock;
addpath('funcs');


Delta_e = 0.15; % 0.3
Delta_i = 0.04; % 0.04
Iattn = 0.02;

time = 4000;
maxFreq = 50;

[r,v,~] = once(Delta_e, Delta_i, Iattn, time);
sig = r(5,300001:end,3);
sig = sig';

%% fft
Fs = 100000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(sig);             % Length of signal
t = (0:L-1)*T;        % Time vector

Y = fft(sig);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

%% pks
[~,idx]  = min(abs(f-maxFreq)); idx = idx+1;
f = f(1:idx); P1 = P1(1:idx);
[pks,locs] = findpeaks(P1);


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