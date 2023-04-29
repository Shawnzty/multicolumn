% this script create 2-d slices for 3d scatter
% 3 dimensions are: DeltaE (x), DeltaI (y), and Isens(z)
clear;
clc;
close all;

rootFolder = "figure_40_diff/";
% ON-ON
data = readFilename(rootFolder+"asAllCriteria/*_*_*_*.png",'%f_%f_%f_%f');
data( all(~data,2), : ) = [];
diff = 2;
idx = data(:,4) < diff & data(:,4) > 1/diff;
coord = data(idx,:);
Iattn = linspace(0,0.1,40);
Delta_i = linspace(0,0.1,40);
Delta_e = linspace(0,0.5,40);

%% Slice by I_attn
fig = figure();
for i = 0:4
    for j = 1:8
        number = i*8+j;
        sfig = subplot(5,8,number);
        sliceIDX = abs(coord(:,3) - Iattn(number)) < 0.001;
        slice = coord(sliceIDX,:);
        tbl = array2table(slice,'VariableNames',{'deltaE','deltaI','Iattn','Diff'});
        scatter(tbl,'deltaE','deltaI','filled','ColorVariable','Diff');
        clim([1/diff diff]);
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
ylabel(h,'\Delta_{I}','FontWeight','bold');
xlabel(h,'\Delta_{E}','FontWeight','bold');
title(h,'Slice by I_{attn}');
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