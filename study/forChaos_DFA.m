clear;
close all;
clc;
initime = clock;
addpath('funcs');


Delta_e = 0.4; % 0.3
Delta_i = 0.04; % 0.04
Iattn = 0.02;

time = 4000;

[r,v,~] = once(Delta_e, Delta_i, Iattn, time);
sig = r(5,100001:end,1);
sig = sig';

%% xt
sigMean = mean(sig);
xi_xMean = sig - sigMean;
xt = zeros(length(sig),1);
xt(1) = xi_xMean(1);
for t = 2:length(sig)
    xt(t) = xt(t-1) + xi_xMean(t);
end

%% F(n)
wdo_strt = 10; wdo_end = 1000;
Fn = zeros(wdo_end-wdo_strt+1,1);
for wdo = wdo_strt:wdo_end
xWdo = 1:wdo;
wdoNum = floor(length(sig)/wdo);
FnTmp = 0;
for i = 1:wdoNum
    xtWdo = xt(1+(i-1)*wdo:i*wdo);
    p = polyfit(xWdo,xtWdo,1);
    ytWdo = p(1)*xWdo + p(2);
    FnTmp = FnTmp + sum((xtWdo - ytWdo').^2);
end
Fn(wdo-wdo_strt+1) = sqrt(FnTmp/length(sig));
end

%% plot
wdo = wdo_strt:wdo_end;
p = polyfit(log(wdo),log(Fn),1);

%% plot
plot(wdo,Fn);
hold on
plot(wdo,exp(p(1)*log(wdo)+p(2)));
set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log');
% xlim([10 1000]);
title("DFA: \Delta_{E}=" + num2str(Delta_e) +...
    ", \Delta_{I}=" + num2str(Delta_i) + ", I_{attn}=" + num2str(Iattn) + ", \alpha=" + num2str(p(1)));
xlabel("Window size");
ylabel("F_n");
filename = append('DFA_',num2str(Delta_e),'_',num2str(Delta_i),'_',num2str(Iattn),'_',num2str(wdo_end),'.png');
location = append('tryOneFigure/',filename);
saveas(gcf, location);