% get pathway current and

pc = getPC(v,g);
interestPC = pc(5,:,:,:);
[head,tail] = period(r(5,150001:200000,:),false);

axlabels = {'1L2/3e','1L2/3i','1L4e','1L4i','1L5e','1L5i','1L6e','1L6i', ...
    '2L2/3e','2L2/3i','2L4e','2L4i','2L5e','2L5i','2L6e','2L6i'};
cond = 4;
strt_prd = head(cond)+150000;
end_prd = tail(cond)+150000;

f = figure();
i = (strt_prd+end_prd)/2;
slice = pc(:,:,i,cond);
h = imagesc(slice);
J = customcolormap([0 0.5 1], [1 0 0;1 1 1;0 0 1]);
c = colorbar; colormap(J);
clim([-1 1]); % colorbar axis
cap = num2str(i);
title("Pathway current at "+"t = "+i/100+" ms", 'FontSize', 14);
xlabel("From")
ylabel("To")
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16])
xticklabels(axlabels);
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16])
yticklabels(axlabels);
ylabel(c,'Intensity','FontSize',12,'Rotation',270);
c.Label.Position(1) = 4;

% Investigate by populations Current to 1L5e
figure()
for cond = 1:5
subplot(2,3,cond)
plt_t = timeax(strt_prd:end_prd);
for i = 1:8
    pc_stgh = squeeze(pc(5,i,strt_prd:end_prd,cond));
    plot(plt_t,pc_stgh,'LineWidth',1.5); % minus for reverse direction
    hold on
end
title("Current to 1L5e in Condition "+num2str(cond), 'FontSize', 14)
legend({'From 1L2/3e','From 1L2/3i','From 1L4e','From 1L4i', ...
    'From 1L5e','From 1L5i','From 1L6e','From 1L6i'},'Location','southeast','NumColumns',2);
xlabel("Time (ms)")
ylabel("Intensity")
end
% legend('Position',[0.1435,0.59328,0.22506,0.31006])