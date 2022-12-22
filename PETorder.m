clear;
close all;
axlabels = {'1L2/3e','1L2/3i','1L4e','1L4i','1L5e','1L5i','1L6e','1L6i', ...
    '2L2/3e','2L2/3i','2L4e','2L4i','2L5e','2L5i','2L6e','2L6i'};
pop = 5;
popEI = 3;
sz = 20;

%% Delta_i: all pathway raw data
load data/0.28_0.28_0.013_0.05_Iattn_0.02.mat;
startX = 0.013; endX = 0.05;
lowY = 0; highY = 80; % 80
x = linspace(startX,endX,size(PET,1));

for cond = 1:5
figure();
hold on;
recX = [0.0355 0.05 0.05 0.0355];
recY = [-200 -200 200 200];
r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r1,0.1);

% recX = [0.036 0.05 0.05 0.036];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);

s = zeros(8,1);
for i = 1:8
    y = PET(:,pop,i,cond);
    s(i) = scatter(x,y,sz,'filled','LineWidth',2);
    hold on;
end

legend(s,axlabels(1:8),'Location','northwest');
xlabel("\Delta_{I}");
ylabel("Energy (\muJ)");
title("Energy transmitted in pathways: Condition" + num2str(cond));
axis([startX endX lowY highY]);
end
%% Delta_i: sum all excitatory or inhibitory effect
% exc = squeeze(PET(:,pop,1,:)) + squeeze(PET(:,pop,3,:)) + ...
%     squeeze(PET(:,pop,5,:)) + squeeze(PET(:,pop,7,:));
% inh = squeeze(PET(:,pop,2,:)) + squeeze(PET(:,pop,4,:)) + ...
%     squeeze(PET(:,pop,6,:)) + squeeze(PET(:,pop,8,:));
% lowY = 65; highY = 95;
% figure();
% hold on
% recX = [0.0315 0.0325 0.0325 0.0315];
% recY = [lowY lowY highY highY];
% r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r1,0.1);
% 
% recX = [0.036 0.05 0.05 0.036];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);
% 
% s1 = scatter(x, exc(:,popEI), sz, 'filled','r');
% s2 = scatter(x, inh(:,popEI), sz, 'filled','b');
% 
% legend([s1 s2],["Excitatory","Inhibitory"]);
% xlabel("\Delta_{I}");
% ylabel("Energy (\muJ)");
% title("Energy transmitted (\Delta_{I})");
% 
% axis([startX endX lowY highY]);

%% Delta_i: E-I by cond
% EI1 = exc(:,1) - inh(:,1);
% EI3 = exc(:,3) - inh(:,3);
% EI4 = exc(:,4) - inh(:,4);
% 
% lowY = -10; highY = 30;
% figure();
% 
% s1 = scatter(x, EI1, sz, 'filled', 'MarkerFaceColor', '#0072BD');
% hold on
% s2 = scatter(x, EI3, sz, 'filled', 'MarkerFaceColor', '#EDB120');
% s3 = scatter(x, EI4, sz, 'filled', 'MarkerFaceColor', '#7E2F8E');
% 
% recX = [0.0315 0.0325 0.0325 0.0315];
% recY = [lowY lowY highY highY];
% r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r1,0.1);
% 
% recX = [0.036 0.05 0.05 0.036];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);
% 
% legend([s1 s2 s3],["cond1", "cond3", "cond4"]);
% axis([startX endX lowY highY]);

%% Delta_i: each E and I by conds
% figure();
% lowY = 55; highY = 95;
% s = zeros(10,1);
% for i = 1:5
%     s(2*i-1) = scatter(x, exc(:,i), sz, 'filled');
%     hold on
%     s(2*i) = scatter(x, inh(:,i), sz, 'filled');
% end
% 
% recX = [0.0315 0.0325 0.0325 0.0315];
% recY = [lowY lowY highY highY];
% r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r1,0.1);
% 
% recX = [0.036 0.05 0.05 0.036];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);
% labels = {'1E', '1I', '2E', '2I', '3E', '3I', '4E', '4I', '5E', '5I'};
% legend(s,labels);
% axis([startX endX lowY highY]);

%% Delta_i: f(E,I)
load data/0.28_0.28_0.013_0.05_Iattn_0.02.mat;
startX = 0.013; endX = 0.05;
% lowY = 55; highY = 95;
sz = 15; pop = 5;
x = linspace(startX,endX,size(PET,1));
exc = squeeze(PET(:,pop,1,:)) + squeeze(PET(:,pop,3,:)) + ...
    squeeze(PET(:,pop,7,:)); % + squeeze(PET(:,pop,7,:));
inh = squeeze(PET(:,pop,2,:)) + squeeze(PET(:,pop,4,:)) + ...
    squeeze(PET(:,pop,6,:)) + squeeze(PET(:,pop,8,:));
s = zeros(5,1);
figure();
for i = 1:5
    out = Fei(exc(:,i), inh(:,i));
    s(i) = scatter(x, out, sz, 'filled');
    hold on
end

recX = [0.0355 0.05 0.05 0.0355];
recY = [-200 -200 200 200];
r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r1,0.1);
% 
% recX = [0.036 0.05 0.05 0.036];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);
% xline(0.032, 'LineWidth', 1.5);
% xline(0.0355, 'LineWidth', 1.5);
labels = {'Cond1', 'Cond2', 'Cond3', 'Cond4', 'Cond5'};
legend(s,labels,'Location','southeast');
axis([0.016 endX -5 30]);
xlabel("\Delta_{I}");

%% Delta_i: contribution of pathway
load data/0.28_0.28_0.013_0.05_Iattn_0.02.mat;
startX = 0.013; endX = 0.05;
lowY = 0; highY = 80; % 80
cond = 5;
x = linspace(startX,endX,size(PET,1));
figure();
hold on;

recX = [0.0355 0.05 0.05 0.0355];
recY = [-200 -200 200 200];
r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r1,0.1);


y1 = PET(:,pop,1,cond); y2 = PET(:,pop,2,cond); y3 = PET(:,pop,6,cond);
s1 = scatter(x,y1,sz,'filled','LineWidth',2);
hold on;
s2 = scatter(x,y2,sz,'filled','LineWidth',2);
s3 = scatter(x,y3,sz,'filled','LineWidth',2);
legend([s1 s2 s3],["1L2/3E", "1L2/3I", "1L5I"]);
xlabel("\Delta_{I}");
ylabel("Energy (\muJ)");
title("Energy transmitted in pathway (\Delta_{I})");
axis([startX endX lowY highY]);

%% Delta_e: all pathway raw data
load data/0_0.5_0.035_0.035_Iattn_0.02.mat;
startX = 0; endX = 0.5;
lowY = 0; highY = 80; % 80
x = linspace(startX,endX,size(PET,1));

for cond = 1:5
figure();
hold on;
recX = [0 0.275 0.275 0];
recY = [-200 -200 200 200];
r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r1,0.1);

% recX = [0.036 0.05 0.05 0.036];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);

s = zeros(8,1);
for i = 1:8
    y = PET(:,pop,i,cond);
    s(i) = scatter(x,y,sz,'filled','LineWidth',2);
    hold on;
end

legend(s,axlabels(1:8),'Location','northwest');
xlabel("\Delta_{E}");
ylabel("Energy (\muJ)");
title("Energy transmitted in pathways: Condition" + num2str(cond));
axis([startX endX lowY highY]);
end

%% sum all excitatory or inhibitory effect
% exc = squeeze(PET(:,pop,1,:)) + squeeze(PET(:,pop,3,:)) + ...
%     squeeze(PET(:,pop,5,:)) + squeeze(PET(:,pop,7,:));
% inh = squeeze(PET(:,pop,2,:)) + squeeze(PET(:,pop,4,:)) + ...
%     squeeze(PET(:,pop,6,:)) + squeeze(PET(:,pop,8,:));
% lowY = 0; highY = 120;
% figure();
% 
% s1 = scatter(x, exc(:,popEI), sz, 'filled','r');
% hold on;
% s2 = scatter(x, inh(:,popEI), sz, 'filled','b');
% 
% recX = [0.11 0.27 0.275 0.11];
% recY = [lowY lowY highY highY];
% r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r1,0.1);
% 
% recX = [0.325 0.33 0.33 0.325];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);
% 
% legend([s1 s2],["Excitatory","Inhibitory"],'Location','northwest');
% xlabel("\Delta_{E}");
% ylabel("Energy (\muJ)");
% title("Energy transmitted (\Delta_{E})");
% 
% axis([startX endX lowY highY]);

%% Delta_e: f(E,I)
load data/0_0.5_0.035_0.035_Iattn_0.02.mat;
startX = 0; endX = 0.5;
% lowY = 55; highY = 95;
sz = 15; pop = 5;
x = linspace(startX,endX,size(PET,1));
exc = squeeze(PET(:,pop,1,:)) + squeeze(PET(:,pop,3,:)) + ...
    squeeze(PET(:,pop,7,:)); % + squeeze(PET(:,pop,7,:));
inh = squeeze(PET(:,pop,2,:)) + squeeze(PET(:,pop,4,:)) + ...
    squeeze(PET(:,pop,6,:)) + squeeze(PET(:,pop,8,:));
s = zeros(5,1);
figure();
for i = 1:5
    out = Fei(exc(:,i), inh(:,i));
    s(i) = scatter(x, out, sz, 'filled');
    hold on
end

recX = [0 0.275 0.275 0];
recY = [-200 -200 200 200];
r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r1,0.1);

% recX = [0.036 0.05 0.05 0.036];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);
% xline(0.275, 'LineWidth', 1.5);
% xline(0.0355, 'LineWidth', 1.5);
labels = {'Cond1', 'Cond2', 'Cond3', 'Cond4', 'Cond5'};
legend(s,labels,'Location','southeast');
axis([startX endX -10 32]);
xlabel("\Delta_{E}");

%% function
function out = Fei(exc,inh)
    out = inh - exc;
end