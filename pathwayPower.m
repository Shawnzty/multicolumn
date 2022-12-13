% [r,v,g] = once(0.3, 0.015, 0.02, 2000);
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

pp = getPP(v,g)*1e-06;
[head,tail] = period(r(5,150001:200000,:),false);

axlabels = {'1L2/3e','1L2/3i','1L4e','1L4i','1L5e','1L5i','1L6e','1L6i', ...
    '2L2/3e','2L2/3i','2L4e','2L4i','2L5e','2L5i','2L6e','2L6i'};
cond = 4;
strt_prd = head(cond)+150000;
end_prd = tail(cond)+150000;

%% pathway power in heatmap
f = figure();
i = round(strt_prd + (end_prd-strt_prd)*0.25);
slice = pp(:,:,i,cond).*p(:,:,cond);
h = imagesc(slice);
J = customcolormap([0 1], [1 0 0;1 1 1]);
c = colorbar; colormap(J);
% set(gca,'ColorScale','log')
% clim([-1 1]); % colorbar axis
title("Pathway power at "+"t = "+num2str(i/100)+" ms", 'FontSize', 12);
xlabel("From")
ylabel("To")
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16])
xticklabels(axlabels);
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16])
yticklabels(axlabels);
ylabel(c,'Power','FontSize',12,'Rotation',270);
c.Label.Position(1) = 4;

%% pathway energy transmission in one period
peTrans = squeeze(sum(pp,3)).*p*0.001*0.01*1000000;
f = figure();
slice = peTrans(:,:,cond);
h = imagesc(slice);
% J = customcolormap([0 1], [1 0 0;1 1 1]);
c = colorbar; colormap('hot');
set(gca,'ColorScale','log')
% clim([-1 1]); % colorbar axis
title("Energy transmission: \Delta_{E}=" + num2str(Delta_e) +...
    ", \Delta_{I}=" + num2str(Delta_i), 'FontSize', 12);
xlabel("From")
ylabel("To")
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16])
xticklabels(axlabels);
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16])
yticklabels(axlabels);
ylabel(c,'Energy (\muJ)','FontSize',12,'Rotation',270);
c.Label.Position(1) = 4;

%% showing the energy transmission of each pathway
figure()
bar(squeeze(peTrans(5,1:8,:)));
xticks([1 2 3 4 5 6 7 8])
xticklabels(axlabels(1:8));
xlabel("From")
ylabel("Energy (\muJ)")
title("Energy transmitted to 1L5e: \Delta_{E}=" + num2str(Delta_e) +...
    ", \Delta_{I}=" + num2str(Delta_i), 'FontSize', 12);

%% Investigate by populations power to 1L5e
figure()
for cond = 1:5
subplot(2,3,cond)
plt_t = timeax(strt_prd:end_prd);
for i = 1:8
    pp_stgh = squeeze(pp(5,i,strt_prd:end_prd,cond))*p(5,i,cond);
    plot(plt_t,pp_stgh,'LineWidth',1.5); % minus for reverse direction
    set(gca, 'YScale', 'log');
    hold on
end
title("Pathway power to 1L5e in Condition "+num2str(cond), 'FontSize', 12)
legend({'From 1L2/3e','From 1L2/3i','From 1L4e','From 1L4i', ...
    'From 1L5e','From 1L5i','From 1L6e','From 1L6i'}, ...
    'Location','southeast','NumColumns',2);
xlabel("Time (ms)")
ylabel("Power")
end
% legend('Position',[0.1435,0.59328,0.22506,0.31006])

%% functions
function pp = getPP(v,g)
%PATHWAYCURRENT Summary of this function goes here
%   Detailed explanation goes here

% get the pathway powers
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
pp = pd.*pd.*g; % pathway current from Y to X
end