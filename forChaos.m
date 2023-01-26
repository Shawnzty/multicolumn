clear;
close all;
clc;
initime = clock;
addpath('funcs');

%% changeable parameter settings
% for parfor
Delta_e = 0.3;
Delta_i = 0.04; % none % changable
Iattn = 0.02;

time = 10000;

disp("Computing -- Delta_e:"+num2str(Delta_e)+", Delta_i:"+num2str(Delta_i)+", Iattn:"+num2str(Iattn));

[r,v,g] = once(Delta_e, Delta_i, Iattn, time);
r_cond1 = r(pop,:,1);
r_cond1 = r_cond1';

[pks,locs] = findpeaks(signal);
