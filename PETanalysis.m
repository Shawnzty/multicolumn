clear;
close all;
axlabels = {'1L2/3e','1L2/3i','1L4e','1L4i','1L5e','1L5i','1L6e','1L6i', ...
    '2L2/3e','2L2/3i','2L4e','2L4i','2L5e','2L5i','2L6e','2L6i'};
pop = 5;
sz = 10;

%% Delta_i
load data/0.3_0.3_0.015_0.045.mat;
startX = 0.015; endX = 0.045;
lowY = 0; highY = 80; % 80
x = linspace(startX,endX,size(PET,2));
figure();
hold on;
recX = [0.027 0.03475 0.03475 0.027];
recY = [lowY lowY highY highY];
r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r1,0.1);

recX = [0.03725 0.045 0.045 0.03725];
recY = [lowY lowY highY highY];
r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r2,0.1);

s = zeros(8,1);
for i = 1:8
    y = PET(1,:,pop,i,1);
    s(i) = scatter(x,y,sz,'filled','LineWidth',2);
    hold on;
end
legend(s,axlabels(1:8));
xlabel("\Delta_{I}");
ylabel("Energy (\muJ)");
title("Energy transmitted in pathway (\Delta_{I})");
axis([startX endX lowY highY]);

% sum all excitatory or inhibitory effect
exc = squeeze(PET(1,:,pop,1,:)) + squeeze(PET(1,:,pop,3,:)) + ...
    squeeze(PET(1,:,pop,5,:)) + squeeze(PET(1,:,pop,7,:));
inh = squeeze(PET(1,:,pop,2,:)) + squeeze(PET(1,:,pop,4,:)) + ...
    squeeze(PET(1,:,pop,6,:)) + squeeze(PET(1,:,pop,8,:));
lowY = 70; highY = 100;
figure();
hold on
recX = [0.027 0.03475 0.03475 0.027];
recY = [lowY lowY highY highY];
r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r1,0.1);

recX = [0.03725 0.045 0.045 0.03725];
recY = [lowY lowY highY highY];
r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r2,0.1);

s1 = scatter(x, exc(:,1), sz, 'filled','r');
s2 = scatter(x, inh(:,1), sz, 'filled','b');

legend([s1 s2],["Excitatory","Inhibitory"]);
xlabel("\Delta_{I}");
ylabel("Energy (\muJ)");
title("Energy transmitted (\Delta_{I})");

axis([startX endX lowY highY]);

% %% Delta_e
% load data/0.1_0.25_0.012_0.012.mat;
% startX = 0.1; endX = 0.25;
% lowY = 0; highY = 9;
% x = linspace(startX,endX,size(PET,1));
% figure();
% hold on
% recX = [startX 0.12 0.12 startX];
% recY = [lowY lowY highY highY];
% r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r1,0.1);
% 
% recX = [0.2275 endX endX 0.2275];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);
% 
% s = zeros(8,1);
% for i = 1:8
%     y = PET(:,1,pop,i,1);
%     s(i) = scatter(x,y,sz,'filled','LineWidth',2);
%     hold on;
% end
% legend(s,axlabels(1:8));
% xlabel("\Delta_{E}");
% ylabel("Energy (\muJ)");
% title("Energy transmitted in pathway (\Delta_{E})");
% 
% % sum all excitatory or inhibitory effect
% exc = squeeze(PET(:,1,pop,1,:)) + squeeze(PET(:,1,pop,3,:)) + ...
%     squeeze(PET(:,1,pop,5,:)) + squeeze(PET(:,1,pop,7,:));
% inh = squeeze(PET(:,1,pop,2,:)) + squeeze(PET(:,1,pop,4,:)) + ...
%     squeeze(PET(:,1,pop,6,:)) + squeeze(PET(:,1,pop,8,:));
% lowY = 6; highY = 14;
% figure();
% hold on
% recX = [startX 0.12 0.12 startX];
% recY = [lowY lowY highY highY];
% r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r1,0.1);
% 
% recX = [0.2275 endX endX 0.2275];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);
% 
% s1 = scatter(x, exc(:,1), sz, 'filled','r');
% s2 = scatter(x, inh(:,1), sz, 'filled','b');
% 
% legend([s1 s2],["Excitatory","Inhibitory"]);
% xlabel("\Delta_{I}");
% ylabel("Energy (\muJ)");
% title("Energy transmitted (\Delta_{E})");
% 
% axis([startX endX lowY highY]);

%% Delta_i and Delta_e
load data/0.1_0.5_0.01_0.03.mat;
startXbottom = 0.1; endXbottom = 0.5;
% lowY = 0; highY = 9;
x = linspace(startXbottom,startXbottom,size(PET,1));
figure();
hold on
% recX = [startX 0.12 0.12 startX];
% recY = [lowY lowY highY highY];
% r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r1,0.1);
% 
% recX = [0.2275 endX endX 0.2275];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);

s = zeros(8,1);
for i = 1:8
    y = PET(:,pop,i,1);
    s(i) = scatter(x,y,sz,'filled','LineWidth',2);
    hold on;
end
legend(s,axlabels(1:8));
xlabel("\Delta_{E}");
ylabel("Energy (\muJ)");
title("Energy transmitted in pathway (\Delta_{E})");

% sum all excitatory or inhibitory effect
exc = squeeze(PET(:,pop,1,:)) + squeeze(PET(:,pop,3,:)) + ...
    squeeze(PET(:,pop,5,:)) + squeeze(PET(:,pop,7,:));
inh = squeeze(PET(:,pop,2,:)) + squeeze(PET(:,pop,4,:)) + ...
    squeeze(PET(:,pop,6,:)) + squeeze(PET(:,pop,8,:));
lowY = 6; highY = 14;
figure();
hold on
% recX = [startX 0.12 0.12 startX];
% recY = [lowY lowY highY highY];
% r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r1,0.1);
% 
% recX = [0.2275 endX endX 0.2275];
% recY = [lowY lowY highY highY];
% r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
% alpha(r2,0.1);

s1 = scatter(x, exc(:,1), sz, 'filled','r');
s2 = scatter(x, inh(:,1), sz, 'filled','b');

legend([s1 s2],["Excitatory","Inhibitory"]);
xlabel("\Delta_{I}");
ylabel("Energy (\muJ)");
title("Energy transmitted (\Delta_{E})");

axis([startX endX lowY highY]);