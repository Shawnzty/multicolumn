function peTrans = getPET(v,g,p)
%PATHWAYCURRENT Summary of this function goes here
%   Detailed explanation goes here

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

peTrans = squeeze(sum(pp,3)).*p*0.001*0.01;
end