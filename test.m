x = linspace(0,0.5);
for i = 1:3
    y1(i,:) = x.^2 + i;
    y2(i,:) = (2*x).^2 + i;
end
hold on
plot(x,y1,'-')
set(gca,'ColorOrderIndex',1)
plot(x,y2,'--')
[lh, labelhandles] = legend({'label 1','label 2','label 3'});
labelhandles(5).LineStyle = '--';
labelhandles(4).YData = [0.83 0.83];
labelhandles(5).XData = [0.0460 0.5057]; labelhandles(5).YData = [0.760 0.760];
