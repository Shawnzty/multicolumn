% this script create a 3-D scatter plot showing different pattern of the
% dynamics, including ON-ON, OFF-ON, OFF-OFF and ON-OFF
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
rootFolder = "figure_40_diff/";
% ON-ON
data = readFilename(rootFolder+"asAllCriteria/*_*_*_*.png",'%f_%f_%f_%f');
data( all(~data,2), : ) = [];
diff = 10;
idx = data(:,4) < diff & data(:,4) > 1/diff;
coord = data(idx,:);
tbl = array2table(coord,'VariableNames',{'deltaE','deltaI','Iattn','Diff'});

figure();
scatter3(tbl,'deltaE','deltaI','Iattn','filled',...
    'ColorVariable','Diff'); L1 = "All";
colorbar
clim([1/diff diff])
colormap("autumn")

hold on

% asCriteria1
data = readFilename(rootFolder+"asCriteria1/*_*_*_*.png",'%f_%f_%f_%f');
data( all(~data,2), : ) = [];
scatter3(data(:,1),data(:,2),data(:,3),"blue",'filled'); L2 = "14>35";

% asCriteria2
data = readFilename(rootFolder+"asCriteria2/*_*_*_*.png",'%f_%f_%f_%f');
data( all(~data,2), : ) = [];
scatter3(data(:,1),data(:,2),data(:,3),"green",'filled'); L3 = "1345>2";

% asAllCriteria but no oscillation
data = readFilename(rootFolder+"asAll_OFF/*_*_*_*.png",'%f_%f_%f_%f');
data( all(~data,2), : ) = [];
scatter3(data(:,1),data(:,2),data(:,3),"magenta",'filled'); L4 = "No osc";

xlabel("\Delta_{E}");
ylabel("\Delta_{I}");
zlabel("I_{attn}");
axis([0 0.5 0 0.1 0 0.1]);
view(0,90);


legend([L1,L2,L3,L4]);

figure();
histogram(coord(:,4));
xlabel("Ratio");