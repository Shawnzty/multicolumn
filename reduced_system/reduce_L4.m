function [r,v,g] = reduce_L4(Delta_e, Delta_i, Iattn, ratio_sens_attn, allTime, stimIn)
%ONCE run the simulation once including five conditions
%   INPUT arguments includes parameters of the column model
%   OUTPUT arguments are the results of computation, including the time
%   courses of firing rate, average membrane potential and synaptic
%   conductance.
%   BY SETTING "ratio_sens_attn = 0", IT IS FOR ONLY ATTENTION CASE!
%   this function only execute computation but NOT SAVE.
if nargin < 6
    stimIn = 1000;
end
% time = allTime;
dt = 0.01;
% timeax = 0:dt:time;
% timeax = timeax';
step_all = allTime/dt;
stimDur = allTime-stimIn;
stimOut = 0;
step_stimIn = stimIn/dt;
step_stim = stimDur/dt;
step_stimOut = stimOut/dt;

% ratio_sens_attn = 3; % ZERO FOR ONLY ATTN
Isens = Iattn*ratio_sens_attn;

ratio_barE_attn = 16/3; % linspace(0.5,5,20) % fix at 16/3=5.33
I_bare = Iattn*ratio_barE_attn; % 3
ratioEi_Ibar = 1600/2000; % fix at 1600/2000 = 0.8
I_bari = I_bare*ratioEi_Ibar;

% fake sensory input
sens_conn_mat = [0.0846, 0.0629;
                 0.0363, 0.0515;
                 0.0411, 0.0057;
                 0.0209, 0.0022];
N_L4E = 10957;
N_L4I = 2739;
ratioIE_Isens = 0.0619/0.0983;

sens_conn_mat(:,1) = sens_conn_mat(:,1)*N_L4E;
sens_conn_mat(:,2) = sens_conn_mat(:,2)*N_L4I;
sens_conn_mat(:,2) = sens_conn_mat(:,2)*ratioIE_Isens;
sens_to_pops = sens_conn_mat(:,1) - sens_conn_mat(:,2); % E-I
sens_to_pops = sens_to_pops/max(sens_to_pops); % normalize
Isens = Isens*sens_to_pops;

I_sensPre_L23 = [Isens(1);Isens(2)];
I_sensNot_L23 = 0.1*I_sensPre_L23;
I_sensBoth_L23 = 1.1*I_sensPre_L23;
I_sensPre_L5 = [Isens(3);Isens(4)];
I_sensNot_L5 = 0.1*I_sensPre_L5;
I_sensBoth_L5 = 1.1*I_sensPre_L5;

ratioEi_Iattn = 0.085/0.1; % 0.085/0.1
I_attn = [Iattn;Iattn*ratioEi_Iattn]; % renormalize to [0,1]

I_bar = repmat([I_bare, I_bari, I_bare, I_bari, I_bare, I_bari, I_bare, I_bari],[1,2])'; % E, I % input current % assigned by sugino
I_bar = repmat(I_bar,[1,1,5]);
Delta = repmat([Delta_e, Delta_i, Delta_e, Delta_i, Delta_e, Delta_i, Delta_e, Delta_i],[1,2])'; % E, I % hetero
Delta = repmat(Delta,[1,1,5]);

V_R = -62;
V_T = -55;
N = repmat([10341 2917 10957 2739 2425 532 7197 1474], [16, 2, 5]); % number of neurons [E, I, E, I, E, I]*2 % [Wagatsuma 2011]
V_syn = repmat([0 -70 0 -70 0 -70 0 -70], [16, 2, 5]); % E:0, I:-70 % reversal potential
g_L = pagetranspose(repmat([0.08 0.1 0.08 0.1 0.08 0.1 0.08 0.1], [1, 2, 5]));
g_bar = repmat([4.069*10^-3, 2.672*10^-2; 3.276*10^-3, 2.138*10^-2], [8, 8, 5]); % raw: To, Column: From % peak conductance
tau_d = repmat([2 5 2 5 2 5 2 5],[16,2,5]); % E:2, I:5 % constant
tau = repmat([0, 0; 0, 0],[8,8,5]); % connect delay not used
% p_base = [0.101, 0.169, 0.088, 0.082, 0.032, 0.000, 0.008, 0.000;
%           0.135, 0.137, 0.032, 0.052, 0.075, 0.000, 0.004, 0.000;
%           0.008, 0.006, 0.050, 0.135, 0.007, 0.0003,0.045, 0.000;
%           0.069, 0.003, 0.079, 0.160, 0.003, 0.000, 0.106, 0.000;
%           0.100, 0.062, 0.051, 0.006, 0.083, 0.373, 0.020, 0.000;
%           0.055, 0.027, 0.026, 0.002, 0.060, 0.316, 0.009, 0.000;
%           0.016, 0.007, 0.021, 0.017, 0.057, 0.020, 0.040, 0.225;
%           0.036, 0.001, 0.003, 0.001, 0.028, 0.008, 0.066, 0.144]; % intracolumn connection probability % [Potjans 2014]
p_base = [0.1184, 0.1552, 0.0846, 0.0629, 0.0323, 0.0000, 0.0076, 0.0000;
          0.1008, 0.1371, 0.0363, 0.0515, 0.0755, 0.0000, 0.0042, 0.0000;
          0.0077, 0.0059, 0.0519, 0.1453, 0.0067, 0.0003, 0.0453, 0.0000;
          0.0691, 0.0029, 0.1093, 0.1597, 0.0033, 0.0000, 0.1057, 0.0000;
          0.1017, 0.0622, 0.0411, 0.0057, 0.0758, 0.3765, 0.0204, 0.0000;
          0.0436, 0.0269, 0.0209, 0.0022, 0.0566, 0.3158, 0.0086, 0.0000;
          0.0156, 0.0066, 0.0211, 0.0166, 0.0572, 0.0197, 0.0401, 0.2252;
          0.0364, 0.0010, 0.0034, 0.0005, 0.0277, 0.0080, 0.0658, 0.1443]; % intracolumn connection probability % [Wagatsuma 2011]
p = [p_base, zeros(8,8); zeros(8,8), p_base];
p(2,9) = 0.1;
p(10,1) = 0.1;
p = repmat(p,[1,1,5]);

% remove L4
p(3:4,:,:) = 0; p(11:12,:,:) = 0;
p(:,3:4,:) = 0; p(:,11:12,:) = 0;

tau_max = max(max(max(tau)));
r = zeros(length(N),step_all+1,5); % Population, Step % variation
v = zeros(length(N),step_all+1,5); % Population, Step % variation [1L2/3e 1L2/3i 1L4e 1L4i ...]
g = zeros(length(N),length(N),step_all+1,5); %Population To, Population From, Step % variation
v(:,1:tau_max+1,:)=-70*ones(length(N),tau_max+1,5); % initial condition

%% conditions
% if condition == 1
    I_bar_ext(:,:,1) = [zeros(2,step_stimIn),I_sensPre_L23*ones(1,step_stim),zeros(2,step_stimOut); % 1L2/3e 1L2/3i;
                 zeros(2,step_all); % 1L4e 1L4i;
                 zeros(2,step_stimIn),I_sensPre_L5*ones(1,step_stim),zeros(2,step_stimOut); % 1L5e 1L5i;
                 zeros(2,step_all); % 1L6e 1L6i;
                 zeros(2,step_stimIn),I_sensNot_L23*ones(1,step_stim),zeros(2,step_stimOut); % 2L2/3e 2L2/3i;
                 zeros(2,step_all); % 2L4e 2L4i;
                 zeros(2,step_stimIn),I_sensNot_L5*ones(1,step_stim),zeros(2,step_stimOut); % 2L5e 2L5i;
                 zeros(2,step_all)]; % 2L6e 2L6i;

% elseif condition == 2
    I_bar_ext(:,:,2) = [zeros(2,step_stimIn),I_sensNot_L23*ones(1,step_stim),zeros(2,step_stimOut); % 1L2/3e 1L2/3i;
                 zeros(2,step_all); % 1L4e 1L4i;
                 zeros(2,step_stimIn),I_sensNot_L5*ones(1,step_stim),zeros(2,step_stimOut); % 1L5e 1L5i;
                 zeros(2,step_all); % 1L6e 1L6i;
                 zeros(2,step_stimIn),I_sensPre_L23*ones(1,step_stim),zeros(2,step_stimOut); % 2L2/3e 2L2/3i;
                 zeros(2,step_all); % 2L4e 2L4i;
                 zeros(2,step_stimIn),I_sensPre_L5*ones(1,step_stim),zeros(2,step_stimOut); % 2L5e 2L5i;
                 zeros(2,step_all)]; % 2L6e 2L6i;

% elseif condition == 3
    I_bar_ext(:,:,3) = [zeros(2,step_stimIn),I_sensBoth_L23*ones(1,step_stim),zeros(2,step_stimOut); % 1L2/3e 1L2/3i;
                 zeros(2,step_all); % 1L4e 1L4i;
                 zeros(2,step_stimIn),I_sensBoth_L5*ones(1,step_stim),zeros(2,step_stimOut); % 1L5e 1L5i;
                 zeros(2,step_all); % 1L6e 1L6i;
                 zeros(2,step_stimIn),I_sensBoth_L23*ones(1,step_stim),zeros(2,step_stimOut); % 2L2/3e 2L2/3i;
                 zeros(2,step_all); % 2L4e 2L4i;
                 zeros(2,step_stimIn),I_sensBoth_L5*ones(1,step_stim),zeros(2,step_stimOut); % 2L5e 2L5i;
                 zeros(2,step_all)]; % 2L6e 2L6i;

% elseif condition == 4
    I_bar_ext(:,:,4) = [zeros(2,step_stimIn),I_sensBoth_L23*ones(1,step_stim),zeros(2,step_stimOut); % 1L2/3e 1L2/3i;
                 zeros(2,step_all); % 1L4e 1L4i;
                 zeros(2,step_stimIn),(I_sensBoth_L5+Iattn)*ones(1,step_stim),zeros(2,step_stimOut); % 1L5e 1L5i;
                 zeros(2,step_all); % 1L6e 1L6i;
                 zeros(2,step_stimIn),I_sensBoth_L23*ones(1,step_stim),zeros(2,step_stimOut); % 2L2/3e 2L2/3i;
                 zeros(2,step_all); % 2L4e 2L4i;
                 zeros(2,step_stimIn),I_sensBoth_L5*ones(1,step_stim),zeros(2,step_stimOut); % 2L5e 2L5i;
                 zeros(2,step_all)]; % 2L6e 2L6i;

% elseif condition == 5
    I_bar_ext(:,:,5) = [zeros(2,step_stimIn),I_sensBoth_L23*ones(1,step_stim),zeros(2,step_stimOut); % 1L2/3e 1L2/3i;
                 zeros(2,step_all); % 1L4e 1L4i;
                 zeros(2,step_stimIn),I_sensBoth_L5*ones(1,step_stim),zeros(2,step_stimOut); % 1L5e 1L5i;
                 zeros(2,step_all); % 1L6e 1L6i;
                 zeros(2,step_stimIn),I_sensBoth_L23*ones(1,step_stim),zeros(2,step_stimOut); % 2L2/3e 2L2/3i;
                 zeros(2,step_all); % 2L4e 2L4i;
                 zeros(2,step_stimIn),(I_sensBoth_L5+Iattn)*ones(1,step_stim),zeros(2,step_stimOut); % 2L5e 2L5i;
                 zeros(2,step_all)]; % 2L6e 2L6i;
                 
% end
%% main simulation
for t = tau_max+1:step_all
        [a,b,c] = fn_abc(g_L,V_T,V_R,squeeze(g(:,:,t,:)),V_syn);
        r(:,t+1,:) = r(:,t,:)+fn_r(a,b,r(:,t,:),v(:,t,:),Delta)*dt;
        v(:,t+1,:) = v(:,t,:)+fn_v(a,b,c,r(:,t,:),v(:,t,:),I_bar+I_bar_ext(:,t,:))*dt;
        g(:,:,t+1,:) = squeeze(g(:,:,t,:))+fn_g(repmat(pagetranspose(r(:,t,:)),[16,1,1]),squeeze(g(:,:,t,:)),tau_d,g_bar,p,N)*dt;% g(to,from)
end

end

%% Functions for a,b,c,r,v,g

function [a,b,c] = fn_abc(g_L,V_T,V_R,g,V_syn)
a = g_L/(V_T-V_R);
b = -g_L*(V_T+V_R)/(V_T-V_R)-sum(g,2);
c = g_L*V_T*V_R/(V_T-V_R)+sum((g.*V_syn),2);
end

function out = fn_r(a,b,r,v,Delta)
out = 2*a.*r.*v+b.*r+a.*Delta/pi;
end

function out = fn_v(a,b,c,r,v,I_bar)
out = a.*v.^2-pi^2*r.^2./a+b.*v+c+I_bar;
end

function out = fn_g(r,g,tau_d,g_bar,p,N)
out = -g./tau_d+g_bar.*p.*N.*r;
end