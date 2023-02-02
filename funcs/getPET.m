function peTrans = getPET(v,g)
%PATHWAYCURRENT Summary of this function goes here
%   Detailed explanation goes here

% Connectivity
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
% p = ones(16,16,5);
% number of neuron
N = repmat([10341 2917 10957 2739 2425 532 7197 1474], [16, 2, 5]);


% get the pathway powers
% from Y to X
v_x = zeros(size(g));
v_y = zeros(size(g)); % mean membrane potential

for i = 1:16 % iterate by column, copy same value of all populations
    v_x(:,i,:,:) = v;
end

for i = 1:16 % iterate by column, give potential to each population
    if mod(i,2) == 0 % even columns are inhibitory
        v_y(:,i,:,:) = -70;
    else
        v_y(:,i,:,:) = 0; % odd columns are excitatory
    end
end

pd = v_y - v_x; % pathway potential difference between Y and X
pp = pd.*pd.*g; % pathway power from Y to X

peTrans = squeeze(sum(pp,3)).*p*0.001*0.01.*N;
end