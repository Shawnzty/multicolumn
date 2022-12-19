%% cond1-cond3 EI, cond4-cond3 EI
clear;
close all;
axlabels = {'1L2/3e','1L2/3i','1L4e','1L4i','1L5e','1L5i','1L6e','1L6i', ...
    '2L2/3e','2L2/3i','2L4e','2L4i','2L5e','2L5i','2L6e','2L6i'};
pop = 5;
sz = 10;

load data/0.1_0.5_0.011_0.035_Iattn_0.04.mat;

startXbottom = 0.1; endXbottom = 0.5;
% lowY = 0; highY = 9;
x = linspace(startXbottom,endXbottom,size(PET,1));

exc = squeeze(PET(:,pop,1,:)) + squeeze(PET(:,pop,3,:)) + ...
    squeeze(PET(:,pop,5,:)) + squeeze(PET(:,pop,7,:));
inh = squeeze(PET(:,pop,2,:)) + squeeze(PET(:,pop,4,:)) + ...
    squeeze(PET(:,pop,6,:)) + squeeze(PET(:,pop,8,:));

diff13E = exc(:,1) - exc(:,3);
diff13I = inh(:,1) - inh(:,3);
diff43E = exc(:,4) - exc(:,3);
diff43I = inh(:,4) - inh(:,3);

figure();
ax1 = axes();
% recX = [startX 0.12 0.12 startX];
% recY = [lowY lowY highY highY];
% r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r1,0.1);
% 
% recX = [0.2275 endX endX 0.2275];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);

s1 = scatter(x, diff13E, sz, 'filled','r');
hold on
s2 = scatter(x, diff13I, sz, 'filled','b');
s3 = scatter(x, diff43E, sz, 'filled', 'MarkerFaceColor', "#EDB120");
s4 = scatter(x, diff43I, sz, 'filled', 'MarkerFaceColor', "#7E2F8E");

ax1.XLim = [startXbottom endXbottom];
% ax1.YLim = [40 110];
legend([s1 s2 s3 s4],["1E-3E", "1I-3I", "4E-3E", "4I-3I"], ...
    'Location','northwest');

% handle second X-axis
ax2 = axes('Position', get(ax1,'Position'), ...
    'XAxisLocation','top', ...
    'Color','none', ...
    'XColor','k');
ax2.YAxis.Visible = 'off';
% ax2.XLim = ax1.XLim;
ax2.XLim = [0.011 0.035];

xlabel(ax1, '\Delta_{E}');
xlabel(ax2, '\Delta_{I}');
ylabel(ax1, "Energy (\muJ)");
pos = [0.15 0.12 0.74 0.76];
set(ax1,'Position',pos);
set(ax2,'Position',pos);
% title("Energy transmitted in pathway");

%% cond1: E-I, cond4: E-I

diffEI = exc - inh;

figure();
ax1 = axes();
% recX = [startX 0.12 0.12 startX];
% recY = [lowY lowY highY highY];
% r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r1,0.1);
% 
% recX = [0.2275 endX endX 0.2275];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);

s1 = scatter(x, diffEI(:,1), sz, 'filled', 'MarkerFaceColor', '#0072BD');
hold on
% s2 = scatter(x, diffEI(:,2), sz, 'filled', 'MarkerFaceColor', '#D95319');
s3 = scatter(x, diffEI(:,3), sz, 'filled', 'MarkerFaceColor', '#EDB120');
s4 = scatter(x, diffEI(:,4), sz, 'filled', 'MarkerFaceColor', '#7E2F8E');
% s5 = scatter(x, diffEI(:,5), sz, 'filled', 'MarkerFaceColor', '#77AC30');

ax1.XLim = [startXbottom endXbottom];
% ax1.YLim = [40 110];
legend([s1 s3 s4],["cond1", "cond3", "cond4"], ...
    'Location','northwest');

% handle second X-axis
ax2 = axes('Position', get(ax1,'Position'), ...
    'XAxisLocation','top', ...
    'Color','none', ...
    'XColor','k');
ax2.YAxis.Visible = 'off';
% ax2.XLim = ax1.XLim;
ax2.XLim = [0.011 0.035];

xlabel(ax1, '\Delta_{E}');
xlabel(ax2, '\Delta_{I}');
ylabel(ax1, "Energy (\muJ)");
pos = [0.15 0.12 0.74 0.76];
set(ax1,'Position',pos);
set(ax2,'Position',pos);
% title("Energy transmitted in pathway");