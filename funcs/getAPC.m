function apc = getAPC(v,g)
%PATHWAYCURRENT Summary of this function goes here
%   Detailed explanation goes here

% get the pathway currents
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
pc = pd.*g; % pathway current from Y to X
sumpc = squeeze(sum(pc(:,:,strt_prd:end_prd,:),3));
dur = end_prd-strt_prd;
apc = sumpc/dur; % average current for one step
end

