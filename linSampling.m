% linear regression of parameters and measurement
clear;
close all;
clc;
initime = clock;

mkdir("figure_linReg");
mkdir("figure_linReg/agree");
mkdir("figure_linReg/disagree");
mkdir("figure_linReg/noOsc")
addpath('funcs');

x1 = 0.125; y1 = 0.013;
x2 = 0.405; y2 = 0.0295;
N = 101;
Iattn = 0.02;
alltime = 4000;

% y = k*x + b

% get points (xn, yn)
% Calculate the slope of the line
m = (y2 - y1) / (x2 - x1);
% Calculate the y-intercept of the line
b = y1 - m*x1;
Delta_E = linspace(0,0.5,N);
Delta_I = Delta_E*m + b;

%% main: get eta
parfor n = 1:N
    startTime = clock;
    disp("Computing -- Delta_e:"+num2str(Delta_E(n))+", Delta_i:"+num2str(Delta_I(n))+", Iattn:"+num2str(Iattn));
    [r,v,g] = once(Delta_E(n), Delta_I(n), Iattn, alltime);
    isPloted = plotTC(r,5, Iattn, Delta_E(n), Delta_I(n),alltime,2,4000);
    disp(etime(clock, startTime));
end
disp(etime(clock, initime)/60);