% this script create a 3-D scatter plot showing different pattern of the
% dynamics, including ON-ON, OFF-ON, OFF-OFF and ON-OFF
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
rootFolder = "figure_Iattn_0.02_2d_4000/";
% ON-ON
data = readFilename(rootFolder+"agree/*_*_*_*_*_*.png",'%f_%f_%f_%f_%f_%f');
data( all(~data,2), : ) = [];

diff = 100;
idx = data(:,4) < diff & data(:,4) > 1/diff & data(:,1) ~= 0.5 & data(:,2) ~= 0.05;
coord = data(idx,:);

tbl = array2table(coord,'VariableNames',{'deltaE','deltaI','Iattn','Diff','Gamma','Beta'});

sz = 5;

figure();
scatter(tbl,'deltaE','deltaI','filled','ColorVariable','Gamma','SizeData',sz);
c = colorbar;
c.FontSize = 10;
caxis([25 35]);
% c.Ticks = [0 0.25 0.5 0.75 1];
% c.TickLabels = {'0.5', '0.67', '1', '1.5', '2'};
ylabel(c,'Center Frequency in Gamma band (Hz)','FontSize',12,'Rotation',270);
c.Label.Position(1) = 3;

set(gca,'Color',[197 201 204]/256);
set(gca,'box','on');
xlabel("\Delta_{E}");
ylabel("\Delta_{I}");
axis([0 0.5 0 0.05]);
title("I_{attn}=0.02")
% legend([L1,L2,L3,L4,L5]);
% plot(linspace(0,0.5,100),linspace(0,0.06,100));

figure();
scatter(tbl,'deltaE','deltaI','filled','ColorVariable','Beta','SizeData',sz);
c = colorbar;
c.FontSize = 10;
caxis([12 25]);
% c.Ticks = [0 0.25 0.5 0.75 1];
% c.TickLabels = {'0.5', '0.67', '1', '1.5', '2'};
ylabel(c,'Center Frequency in Beta band (Hz)','FontSize',12,'Rotation',270);
c.Label.Position(1) = 3;

set(gca,'Color',[197 201 204]/256);
set(gca,'box','on');
xlabel("\Delta_{E}");
ylabel("\Delta_{I}");
axis([0 0.5 0 0.05]);
title("I_{attn}=0.02")
% legend([L1,L2,L3,L4,L5]);
% plot(linspace(0,0.5,100),linspace(0,0.06,100));