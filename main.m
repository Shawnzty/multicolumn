clear;
close all;
clc;
initime = clock;

mkdir("figure");
mkdir("figure/ON_ON");
mkdir("figure/ON_ON/asCriteria1");
mkdir("figure/ON_ON/asCriteria2");
mkdir("figure/ON_ON/asAllCriteria");
mkdir("figure/OFF_OFF");
mkdir("figure/OFF_OFF/asCriteria1");
mkdir("figure/OFF_OFF/asCriteria2");
mkdir("figure/OFF_OFF/asAllCriteria");
mkdir("figure/OFF_ON");
mkdir("figure/OFF_ON/asCriteria1");
mkdir("figure/OFF_ON/asCriteria2");
mkdir("figure/OFF_ON/asAllCriteria");
mkdir("figure/ON_OFF");
mkdir("figure/ON_OFF/asCriteria1");
mkdir("figure/ON_OFF/asCriteria2");
mkdir("figure/ON_OFF/asAllCriteria");
mkdir("figure/inf");

%% changeable parameter settings

parfor Delta_e_n = 1:10 % linspace(0.001,0.5,10) % 0.28 % changable
    Delta_e = 0.001+ Delta_e_n*(0.5-0.001)/10;
for Delta_i = linspace(0.001,0.5,10) % none % changable
for Iattn = linspace(0.01,3,10)

% for Delta_e = 0.42684% 0.28 % changable
% for Delta_i = 0.16632 % none % changable
% for Iattn = 0.01

close all;
startTime = clock;
disp("Delta_e:"+num2str(Delta_e)+", Delta_i:"+num2str(Delta_i)+", Iattn:"+num2str(Iattn));

for ratio_sens_attn = 1 % linspace(0.5,5,20) % fix at 9000/3000 = 3
Isens =  Iattn*ratio_sens_attn;

for ratio_barE_attn = 1 % linspace(0.5,5,20) % fix at 16/3=5.33
I_bare = Iattn*ratio_barE_attn; % 3
ratioEi_Ibar = 0.8; % fix at 1600/2000 = 0.8
I_bari = I_bare*ratioEi_Ibar;

ratioEi_Isens = 0.0619/0.0983; % 0.0619/0.0983
I_sensPre = [Isens;Isens*ratioEi_Isens]; % [E;I][6;3]
I_sensNot = 0.1*I_sensPre; % 0.01
I_sensBoth = 1.1*I_sensPre; % 0.6

ratioEi_Iattn = 0.085/0.1; % 0.085/0.1
I_attn = [Iattn;Iattn*ratioEi_Iattn];

I_bar = repmat([I_bare, I_bari, I_bare, I_bari, I_bare, I_bari, I_bare, I_bari],[1,2])'; % E, I % input current % assigned by sugino
I_bar = repmat(I_bar,[1,1,5]);
Delta = repmat([Delta_e, Delta_i, Delta_e, Delta_i, Delta_e, Delta_i, Delta_e, Delta_i],[1,2])'; % E, I % hetero
Delta = repmat(Delta,[1,1,5]);

[r,v,g] = once(I_bar, I_sensPre, I_sensNot, I_sensBoth, I_attn, Delta);
isPloted = plotTC(r,v,g,5, Iattn, Delta_e,Delta_i,2,3000);
disp(etime(clock, startTime));
end
end
end
end
end
disp(etime(clock, initime)/60);
