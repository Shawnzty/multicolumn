% this script create 2-d slices for 3d scatter
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
clear;
clc;
close all;

rootFolder = "figure_40_diff/";
% ON-ON
data = readFilename(rootFolder+"asAllCriteria/*_*_*_*.png",'%f_%f_%f_%f');
data( all(~data,2), : ) = [];
diff = 10;
idx = data(:,4) < diff & data(:,4) > 1/diff;
coord = data(idx,:);

data1 = readFilename(rootFolder+"asCriteria1/*_*_*_*.png",'%f_%f_%f_%f');
data1( all(~data1,2), : ) = [];

data2 = readFilename(rootFolder+"asCriteria2/*_*_*_*.png",'%f_%f_%f_%f');
data2( all(~data1,2), : ) = [];

data3 = readFilename(rootFolder+"asAll_OFF/*_*_*_*.png",'%f_%f_%f_%f');
data3( all(~data1,2), : ) = [];

Iattn = linspace(0,0.1,40);
Delta_i = linspace(0,0.1,40);
Delta_e = linspace(0,0.5,40);

%% Slice by I_attn
fig = figure();
for i = 0:4
    for j = 1:8
        number = i*8+j;
        sfig = subplot(5,8,number);
        sz = 5;
        sliceIDX = abs(coord(:,3) - Iattn(number)) < 0.001;
        slice = coord(sliceIDX,:);
        tbl = array2table(slice,'VariableNames',{'deltaE','deltaI','Iattn','Diff'});
        scatter(tbl,'deltaE','deltaI','filled','ColorVariable','Diff','SizeData',sz);
        clim([1/diff diff]);
        L1 = "All";
        hold on
        sliceIDX = abs(data1(:,3) - Iattn(number)) < 0.001;
        slice = data1(sliceIDX,:);
        scatter(slice(:,1),slice(:,2),sz,'filled',"MarkerFaceColor","#D95319"); L2 = "14>35";
        sliceIDX = abs(data2(:,3) - Iattn(number)) < 0.001;
        slice = data2(sliceIDX,:);
        scatter(slice(:,1),slice(:,2),sz,'filled',"MarkerFaceColor","#7E2F8E"); L3 = "1345>2";
        sliceIDX = abs(data3(:,3) - Iattn(number)) < 0.001;
        slice = data3(sliceIDX,:);
        scatter(slice(:,1),slice(:,2),sz,'filled',"MarkerFaceColor","#000000"); L4 = "No osc";
        sfig.XLabel.Visible = 'off';
        sfig.YLabel.Visible = 'off';
        title("I_{attn}="+Iattn(number));
        axis([0 0.5 0 0.1]);
    end
end
h = axes(fig,'visible','off');
h.Title.Visible = 'on';
h.XLabel.Visible = 'on';
h.YLabel.Visible = 'on';
% legend([L1,L2,L3,L4]);
ylabel(h,'\Delta_{I}','FontWeight','bold');
xlabel(h,'\Delta_{E}','FontWeight','bold');
title(h,'Slice by I_{attn}, purple: 1345>2, orange: 14>35');
c = colorbar(h,'Position',[0.93 0.168 0.01 0.7]);  % attach colorbar to h
clim([1/diff diff]);

%% Slice by Delta_e
fig = figure();
for i = 0:4
    for j = 1:8
        number = i*8+j;
        sfig = subplot(5,8,number);
        sliceIDX = abs(coord(:,1) - Delta_e(number)) < 0.001;
        slice = coord(sliceIDX,:);
        tbl = array2table(slice,'VariableNames',{'deltaE','deltaI','Iattn','Diff'});
        scatter(tbl,'deltaI','Iattn','filled','ColorVariable','Diff');
        clim([1/diff diff]);
        sfig.XLabel.Visible = 'off';
        sfig.YLabel.Visible = 'off';
        title("\Delta_{E}="+Delta_e(number));
        axis([0 0.1 0 0.1]);
    end
end
h = axes(fig,'visible','off');
h.Title.Visible = 'on';
h.XLabel.Visible = 'on';
h.YLabel.Visible = 'on';
ylabel(h,'I_{attn}','FontWeight','bold');
xlabel(h,'\Delta_{I}','FontWeight','bold');
title(h,'Slice by \Delta_{E}');
c = colorbar(h,'Position',[0.93 0.168 0.01 0.7]);  % attach colorbar to h
clim([1/diff diff]);

%% Slice by Delta_i
fig = figure();
for i = 0:7
    for j = 1:5
        number = i*5+j;
        sfig = subplot(8,5,number);
        sliceIDX = abs(coord(:,2) - Delta_i(number)) < 0.001;
        slice = coord(sliceIDX,:);
        tbl = array2table(slice,'VariableNames',{'deltaE','deltaI','Iattn','Diff'});
        scatter(tbl,'deltaE','Iattn','filled','ColorVariable','Diff');
        clim([1/diff diff]);
        sfig.XLabel.Visible = 'off';
        sfig.YLabel.Visible = 'off';
        title("\Delta_{i}="+Delta_i(number));
        axis([0 0.5 0 0.1]);
    end
end
h = axes(fig,'visible','off');
h.Title.Visible = 'on';
h.XLabel.Visible = 'on';
h.YLabel.Visible = 'on';
ylabel(h,'I_{attn}','FontWeight','bold');
xlabel(h,'\Delta_{E}','FontWeight','bold');
title(h,'Slice by \Delta_{i}');
% c = colorbar(h,'Position',[0.93 0.168 0.01 0.7]);  % attach colorbar to h
clim([1/diff diff]);

%% Histogram
figure();
histogram(coord(:,4));