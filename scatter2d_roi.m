% this script create a 3-D scatter plot showing different pattern of the
% dynamics, including ON-ON, OFF-ON, OFF-OFF and ON-OFF
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
rootFolder = "figure/";
% ON-ON
data = readFilename(rootFolder+"agree/*_*_*_*_*_*.png",'%f_%f_%f_%f_%f_%f');
data( all(~data,2), : ) = [];

figure();
diff = 2;
sz = 5;
idx = data(:,4) < diff & data(:,4) > 1/diff;
coord = data(idx,:);
tbl = array2table(coord,'VariableNames',{'deltaE','deltaI','Iattn','Diff','Gamma','Beta'});

scatter(tbl,'deltaE','deltaI','filled','ColorVariable','Diff','SizeData',sz,'Marker','square'); L1 = "All";
colorbar
clim([1/diff diff])

xlabel("\Delta_{E}");
ylabel("\Delta_{I}");
axis([0 0.5 0 0.05]);
title("I_{attn}=0.02")
% legend([L1,L2,L3,L4,L5]);
% plot(linspace(0,0.5,100),linspace(0,0.06,100));

figure();
histogram(data(:,4));
xlabel("Ratio");