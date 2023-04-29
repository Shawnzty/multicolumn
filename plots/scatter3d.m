% this script create a 3-D scatter plot showing different pattern of the
% dynamics, including ON-ON, OFF-ON, OFF-OFF and ON-OFF
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
rootFolder = "figure_40_diff/";
% ON-ON
data = readFilename(rootFolder+"asAllCriteria/*_*_*_*.png",'%f_%f_%f_%f');
data( all(~data,2), : ) = [];
diff = 2;
idx = data(:,4) < diff & data(:,4) > 1/diff;
coord = data(idx,:);
tbl = array2table(coord,'VariableNames',{'deltaE','deltaI','Iattn','Diff'});
figure();
scatter3(tbl,'deltaE','deltaI','Iattn','filled',...
    'ColorVariable','Diff');
colorbar
clim([1/diff diff])
colormap("autumn")
% hold on
% 
% 
% coord = readFilename(rootFolder+"OFF_ON/asAllCriteria/*_*_*.png",'%f_%f_%f');
% scatter3(coord(:,1),coord(:,2),coord(:,3),"r");
% 
% % OFF-OFF
% coord = readFilename(rootFolder+"OFF_OFF/asAllcriteria/*_*_*.png",'%f_%f_%f');
% scatter3(coord(:,1),coord(:,2),coord(:,3),"r");
% 
% % ON-OFF
% coord = readFilename(rootFolder+"ON_OFF/asAllcriteria/*_*_*.png",'%f_%f_%f');
% scatter3(coord(:,1),coord(:,2),coord(:,3),"r");
% 
% scatter3(0.15517, 0.02069, 0.048276,"b","MarkerFaceColor","b");

xlabel("\Delta_{E}");
ylabel("\Delta_{I}");
zlabel("I_{attn}");
axis([0 0.5 0 0.05 0 0.1]);
view(0,90);
% legend(["ON-ON","OFF-ON","OFF-OFF","ON-OFF"]);

figure();
histogram(coord(:,4));
xlabel("Ratio");