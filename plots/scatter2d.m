% this script create a 3-D scatter plot showing different pattern of the
% dynamics, including ON-ON, OFF-ON, OFF-OFF and ON-OFF
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
rootFolder = "figure_Iattn_0.02_2d/";
% ON-ON
data = readFilename(rootFolder+"asAllCriteria/*_*_*_*.png",'%f_%f_%f_%f');
data( all(~data,2), : ) = [];
diff = 2;
idx = data(:,4) < diff & data(:,4) > 1/diff;
coord = data(idx,:);
tbl = array2table(coord,'VariableNames',{'deltaE','deltaI','Iattn','Diff'});
figure();
scatter(tbl,'deltaE','deltaI','filled','ColorVariable','Diff','SizeData',20); % ,"Marker","o");
colorbar
clim([1/diff diff])

xlabel("\Delta_{E}");
ylabel("\Delta_{I}");
axis([0 0.5 0 0.1]);
title("I_{attn}=0.02")

figure();
histogram(coord(:,4));
xlabel("Ratio");