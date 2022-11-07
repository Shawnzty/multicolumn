% this script create a 3-D scatter plot showing different pattern of the
% dynamics, including ON-ON, OFF-ON, OFF-OFF and ON-OFF
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
rootFolder = "testrun_criteria_figure/";
% ON-ON
coord = readFilename(rootFolder+"ON_ON/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"r");
hold on
coord = readFilename(rootFolder+"ON_ON/asCriteria1/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"r");
coord = readFilename(rootFolder+"ON_ON/asCriteria2/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"r");
coord = readFilename(rootFolder+"ON_ON/asAllCriteria/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"r");

% OFF-ON
coord = readFilename(rootFolder+"OFF_ON/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"blue");
coord = readFilename(rootFolder+"OFF_ON/asCriteria1/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"blue");
coord = readFilename(rootFolder+"OFF_ON/asCriteria2/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"blue");
coord = readFilename(rootFolder+"OFF_ON/asAllCriteria/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"blue");


% OFF-OFF
coord = readFilename(rootFolder+"OFF_OFF/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"yellow");
coord = readFilename(rootFolder+"OFF_OFF/asCriteria1/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"yellow");
coord = readFilename(rootFolder+"OFF_OFF/asCriteria2/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"yellow");
coord = readFilename(rootFolder+"OFF_OFF/asAllCriteria/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"yellow");

% ON-OFF
coord = readFilename(rootFolder+"ON_OFF/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"green");
coord = readFilename(rootFolder+"ON_OFF/asCriteria1/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"green");
coord = readFilename(rootFolder+"ON_OFF/asCriteria2/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"green");
coord = readFilename(rootFolder+"ON_OFF/asAllCriteria/*_*_*.png",'%f_%f_%f');
scatter3(coord(:,1),coord(:,2),coord(:,3),"green");

% % inf
% coord = readFilename(rootFolder+"inf/*_*_*.png",'%f_%f_%f');
% scatter3(coord(:,1),coord(:,2),coord(:,3),"black");

xlabel("\Delta_{E}");
ylabel("\Delta_{I}");
zlabel("I_{attn}");
legend(["ON-ON","OFF-ON","OFF-OFF","ON-OFF"]);