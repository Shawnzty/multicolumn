function apc = getAPC(v,g,strt_prd,end_prd)
%PATHWAYCURRENT Summary of this function goes here
%   Detailed explanation goes here

% get the pathway currents
% from Y to X
step_all = size(v,2)-1;
v_x = zeros(16,16,step_all+1,5);
v_y = zeros(16,16,step_all+1,5); % mean membrane potential

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
sumpc = squeeze(sum(pc(:,:,strt_prd:end_prd,:),3))*0.001*0.01;
dur = (end_prd-strt_prd)*0.001*0.01;
apc = sumpc/dur;
end

