% this script create a 3-D scatter plot showing different pattern of the
% dynamics, including ON-ON, OFF-ON, OFF-OFF and ON-OFF
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
rootFolder = "figure_200_0.02/";
% ON-ON
data = readFilename(rootFolder+"agree/*_*_*_*_*_*.png",'%f_%f_%f_%f_%f_%f');
data( all(~data,2), : ) = [];

diff = 2;
idx = data(:,4) < diff & data(:,4) > 1/diff & data(:,1) ~= 0.5 & data(:,2) ~= 0.05;
coord = data(idx,:);

topColor = [256 0 0]/256; % R G B
middleColor = [256 256 256]/256;
bottomColor = [0 0 256]/256;
upperHalf = [linspace(topColor(1),middleColor(1),100);linspace(topColor(2),middleColor(2),100);linspace(topColor(3),middleColor(3),100)]';
lowerHalf = [linspace(middleColor(1),bottomColor(1),100);linspace(middleColor(2),bottomColor(2),100);linspace(middleColor(3),bottomColor(3),100)]';
colors = cat(1,upperHalf(1:end-1,:),lowerHalf);

upperTicks = linspace(1,diff,100);
lowerTicks = flip(1./upperTicks);
ticks = flip(cat(2,lowerTicks(1:end-1),upperTicks)');


coordColor = zeros(length(coord),3);
% tbl = array2table(coord,'VariableNames',{'deltaE','deltaI','Iattn','Diff','Gamma','Beta'});

sz = 10;

figure();
for i = 1:length(coord)
    [val,idx]=min(abs(coord(i,4)-ticks));
    coordColor(i,:) = colors(idx,:);
end

scatter(coord(:,1),coord(:,2),sz,coordColor,'filled','Marker','square');

J = customcolormap([0 0.5 1], [topColor;middleColor;bottomColor]);
colormap(J);
c = colorbar;
c.FontSize = 10;
% caxis([0.5 2]);
c.Ticks = [0 0.25 0.5 0.75 1];
c.TickLabels = {'0.5', '0.67', '1', '1.5', '2'};
% c.Ticks = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 5.0 10.0 15.0 20.0 25.0]
ylabel(c,'Recovery ratio','FontSize',12,'Rotation',270);
c.Label.Position(1) = 3;

set(gca,'Color',[197 201 204]/256);
set(gca,'box','on');
xlabel("\Delta_{E}");
ylabel("\Delta_{I}");
axis([0 0.5 0 0.05]);
title("I_{attn}=0.02")
% legend([L1,L2,L3,L4,L5]);
% plot(linspace(0,0.5,100),linspace(0,0.06,100));

% figure();
% histogram(data(:,4));
% xlabel("Ratio");