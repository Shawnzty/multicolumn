clear;
close all;
axlabels = {'1L2/3e','1L2/3i','1L4e','1L4i','1L5e','1L5i','1L6e','1L6i', ...
    '2L2/3e','2L2/3i','2L4e','2L4i','2L5e','2L5i','2L6e','2L6i'};
pop = 5;
sz = 10;

%%
load data/0.3_0.3_0.015_0.045.mat;

x = linspace(0.015,0.045,size(PET,2));
figure();
for i = 1:10
%     bar(squeeze(PET(1,i,pop,1:8,:)));
%     hold on;
    y = PET(1,:,pop,i,1);
    scatter(x,y,sz,'filled','LineWidth',2);
    hold on;
end
legend(axlabels(1:8));
xlabel("\Delta_{I}");
ylabel("Energy (\muJ)");
title("Energy transmitted in pathway (\Delta_{I})");
xline(0.027);
xline(0.02725);
xline(0.03475);
xline(0.035);
xline(0.037);
xline(0.03725);

% sum all excitatory or inhibitory effect
exc = squeeze(PET(1,:,pop,1,:)) + squeeze(PET(1,:,pop,3,:)) + ...
    squeeze(PET(1,:,pop,5,:)) + squeeze(PET(1,:,pop,7,:));
inh = squeeze(PET(1,:,pop,2,:)) + squeeze(PET(1,:,pop,4,:)) + ...
    squeeze(PET(1,:,pop,6,:)) + squeeze(PET(1,:,pop,8,:));
figure();
hold on
recX = [0.027,0.03475,0.03475,0.027];
recY = [70 70 100 100];
r1 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r1,0.1);

recX = [0.03725, 0.045, 0.045, 0.03725];
recY = [70 70 100 100];
r2 = fill(recX, recY, [245 189 31]/256,'LineStyle','none');
alpha(r2,0.1);

s1 = scatter(x, exc(:,1), sz, 'filled','r');
s2 = scatter(x, inh(:,1), sz, 'filled','b');

legend([s1 s2],["Excitatory","Inhibitory"]);
xlabel("\Delta_{I}");
ylabel("Energy (\muJ)");
title("Energy transmitted (\Delta_{I})");

axis([0.015 0.045 70 100]);

%%
% load 0.1_0.2_0.01_0.01.mat;
% x = linspace(0.1,0.2,size(PET,1));
% figure();
% for i = 1:10
% %     bar(squeeze(PET(1,i,pop,1:8,:)));
% %     hold on;
%     y = PET(:,1,pop,i,1);
%     scatter(x,y,sz,'filled','LineWidth',2);
%     hold on;
% end
% legend(axlabels(1:8));
% xlabel("\Delta_{E}");
% ylabel("Energy (\muJ)");
% title("Energy transmitted in pathway (\Delta_{E})");