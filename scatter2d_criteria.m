% this script create a 3-D scatter plot showing different pattern of the
% dynamics, including ON-ON, OFF-ON, OFF-OFF and ON-OFF
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
rootFolder = "figure/";
% ON-ON
agree = readFilename(rootFolder+"agree/*_*_*_*_*_*.png",'%f_%f_%f_%f_%f_%f');
agree( all(~agree,2), : ) = [];
disagree = readFilename(rootFolder+"disagree/*_*_*_*_*_*.png",'%f_%f_%f_%f_%f_%f');
disagree( all(~disagree,2), : ) = [];
noosc = readFilename(rootFolder+"noOsc/*_*_*_*_*_*.png",'%f_%f_%f_%f_%f_%f');
noosc( all(~noosc,2), : ) = [];

diff = 2;
idx = agree(:,4) < diff & agree(:,4) > 1/diff;
roi = agree(idx,:);

idx = ~idx;
outRatio = agree(idx,:);
disagree = [disagree;outRatio];

figure();
sz = 4;
scatter(roi(:,1), roi(:,2), sz,'filled',"MarkerFaceColor",[153 79 178]/256,'Marker','square'); L1 = "ROI";
hold on
scatter(disagree(:,1), disagree(:,2), sz,'filled',"MarkerFaceColor",[245 189 31]/256,'Marker','square'); L2 = "Disagree";
scatter(noosc(:,1), noosc(:,2), sz,'filled',"MarkerFaceColor","#011936",'Marker','square'); L3 = "No osc";
scatter(0.2,0.005, sz,'filled',"MarkerFaceColor","#FFFFFF",'Marker','square'); L4 = "Inf";

set(gca,'box','on');
xlabel("\Delta_{E}");
ylabel("\Delta_{I}");
axis([0 0.5 0 0.05]);
title("I_{attn}=0.02")
legend([L1,L2,L3,L4],'Location','SouthEast');
% plot(linspace(0,0.5,100),linspace(0,0.06,100));