% this script create a 3-D scatter plot showing different pattern of the
% dynamics, including ON-ON, OFF-ON, OFF-OFF and ON-OFF
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
rootFolder = "figure_Iattn_0.02_2d/";
% ON-ON
data = readFilename(rootFolder+"asAllCriteria/*_*_*_*.png",'%f_%f_%f_%f');
data( all(~data,2), : ) = [];
data1 = readFilename(rootFolder+"asCriteria1/*_*_*_*.png",'%f_%f_%f_%f');
data1( all(~data1,2), : ) = [];

data2 = readFilename(rootFolder+"asCriteria2/*_*_*_*.png",'%f_%f_%f_%f');
data2( all(~data2,2), : ) = [];

data3 = readFilename(rootFolder+"asAll_OFF/*_*_*_*.png",'%f_%f_%f_%f');
data3( all(~data3,2), : ) = [];

data4 = readFilename(rootFolder+"none/*_*_*_*.png",'%f_%f_%f_%f');
data4( all(~data4,2), : ) = [];

diff = 2;
sz = 20;
idx = data(:,4) < diff & data(:,4) > 1/diff;
coord = data(idx,:);
tbl = array2table(coord,'VariableNames',{'deltaE','deltaI','Iattn','Diff'});
figure();
scatter(tbl,'deltaE','deltaI','filled','ColorVariable','Diff','SizeData',sz); L1 = "All";
colorbar
clim([1/diff diff])

hold on
scatter(data1(:,1), data1(:,2), sz,'filled',"MarkerFaceColor","#D95319"); L2 = "Criteria1";
scatter(data2(:,1), data2(:,2), sz,'filled',"MarkerFaceColor","#7E2F8E"); L3 = "Criteria2";
scatter(data3(:,1), data3(:,2), sz,'filled',"MarkerFaceColor","#000000"); L4 = "All no osc";
scatter(data4(:,1), data4(:,2), sz,'filled',"MarkerFaceColor","#949893"); L5 = "None";


xlabel("\Delta_{E}");
ylabel("\Delta_{I}");
axis([0 0.5 0 0.05]);
title("I_{attn}=0.02")
legend([L1,L2,L3,L4,L5]);
% plot(linspace(0,0.5,100),linspace(0,0.06,100));
yline(0.02)
xline(0.1)
xline(0.2)
xline(0.3)
xline(0.4)
xline(0.5)

figure();
histogram(coord(:,4));
xlabel("Ratio");