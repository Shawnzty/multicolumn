clear;
close all;
initime = clock;
addpath('funcs');

% get the change of PET in parameter space
Delta_e_start = 0.1; % cannot equal to 0
Delta_e_end = 0.5; % can equal to 0.5
Delta_i_start = 0.011; % cannot equal to 0
Delta_i_end = 0.035; % can equal to 0.5
Delta_steps = 101;

Iattn = 0.02;
time = 10000;
strt_prd = 300001;
end_prd = 1000000;

% container
PET = zeros(Delta_steps, 16, 16, 5);

% parameter
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

for n = 1:Delta_steps
    startTime = clock;
    Delta_e = Delta_e_start + (n-1)*(Delta_e_end-Delta_e_start)/(Delta_steps-1);
    Delta_i = Delta_i_start + (n-1)*(Delta_i_end-Delta_i_start)/(Delta_steps-1);
    [r,v,g] = once(Delta_e, Delta_i, Iattn, time);
    pp = getPP(v,g); % power in unit of micro watt (\mu W), size: 16*16*time*5
    peTrans = squeeze(sum(pp(:,:,strt_prd:end_prd,:),3)).*p*0.001*0.01; % 16*16*5
    PET(n,:,:,:) = peTrans;
    disp(etime(clock, startTime));
end

filename = append(num2str(Delta_e_start),'_',num2str(Delta_e_end),'_',num2str(Delta_i_start),'_',num2str(Delta_i_end),'.mat');
save(filename,'PET'); 
disp(etime(clock, initime)/60);