clear;
close all;
clc;
initime = clock;

mkdir("figure");
mkdir("figure/agree");
mkdir("figure/disagree");
mkdir("figure/noOsc")

% mkdir("figure/ON_ON");
% mkdir("figure/ON_ON/asCriteria1");
% mkdir("figure/ON_ON/asCriteria2");
% mkdir("figure/ON_ON/asAllCriteria");
% mkdir("figure/OFF_OFF");
% mkdir("figure/OFF_OFF/asCriteria1");
% mkdir("figure/OFF_OFF/asCriteria2");
% mkdir("figure/OFF_OFF/asAllCriteria");
% mkdir("figure/OFF_ON");
% mkdir("figure/OFF_ON/asCriteria1");
% mkdir("figure/OFF_ON/asCriteria2");
% mkdir("figure/OFF_ON/asAllCriteria");
% mkdir("figure/ON_OFF");
% mkdir("figure/ON_OFF/asCriteria1");
% mkdir("figure/ON_OFF/asCriteria2");
% mkdir("figure/ON_OFF/asAllCriteria");

%% changeable parameter settings
% for parfor
delta_e_start = 0; % cannot equal to 0
delta_e_end = 0.5; % can equal to 0.5
delta_e_steps = 200;

delta_i_start = 0; % cannot equal to 0
delta_i_end = 0.05; % can equal to 0.5
delta_i_steps = 200;

parfor Delta_e_n = 1:delta_e_steps % linspace(0.001,0.5,10) % 0.28 % changable
    Delta_e = delta_e_start+ Delta_e_n*(delta_e_end/delta_e_steps);
% for Delta_e = 0.0625

for Delta_i_n = 1:delta_i_steps % none % changable
    Delta_i = delta_i_start + Delta_i_n*(delta_i_end/delta_i_steps);

% for Iattn = linspace((0.05/20)+0.1,0.15,20)
Iattn = 0.05;
% if Iattn == 0
%     continue
% end

close all;
startTime = clock;
disp("Computing -- Delta_e:"+num2str(Delta_e)+", Delta_i:"+num2str(Delta_i)+", Iattn:"+num2str(Iattn));

[r,v,g] = once(Delta_e, Delta_i, Iattn, 2000);
isPloted = plotTC(r,5, Iattn, Delta_e,Delta_i,2,4000);
disp(etime(clock, startTime));
% end
end
end
disp(etime(clock, initime)/60);
