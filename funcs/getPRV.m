function prv = getPRV(r,v,g,strt_prd,end_prd)
%GETPRV Summary of this function goes here
%   Detailed explanation goes here

% get the pathway currents
% from Y to X
step_all = end_prd - strt_prd;
v_x = zeros(16,16,step_all,5);
v_y = zeros(16,16,step_all,5); % mean membrane potential

for i = 1:16 % iterate by column, copy same value of all populations
    v_x(:,i,:,:) = v(:,strt_prd : end_prd-1,:);
end

for i = 1:16 % iterate by column, give potential to each population
    if mod(i,2) == 0 % even columns are inhibitory
        v_y(:,i,:,:) = -70;
    else
        v_y(:,i,:,:) = 0; % odd columns are excitatory
    end
end

pd = v_y - v_x; % pathway potential difference between Y and X
pc = pd.*g(:,:,strt_prd:end_prd-1,:); % pathway current from Y to X

% get pr
dv = v(:,strt_prd+1:end_prd,:) - v(:,strt_prd:end_prd-1,:);
dr = r(:,strt_prd+1:end_prd,:) - r(:,strt_prd:end_prd-1,:);
dvdr = dv ./ dr;

rdvdr = zeros(16,16,step_all,5);
for i = 1:16
    value = squeeze(r(i,strt_prd:end_prd-1,:)).*squeeze(dvdr(i,:,:));
    for j = 1:16
    rdvdr(i,j,:,:) = value;
    end
end
pr = g(:,:,strt_prd:end_prd-1,:) .* rdvdr;
pcpr = pc - pr;
sumpcpr = squeeze(sum(pcpr,3))*0.001*0.01;
dur = (end_prd-strt_prd)*0.001*0.01;
prv = sumpcpr/dur;
end

