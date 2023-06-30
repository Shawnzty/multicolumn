pop = 1;
figure();

hold on;
 
% recX = [1 4 4 1];
% recY = [0 0 200 200];
% r1 = fill(recX, recY, 0.9*[209 211 212]/256,'LineStyle','none');
% alpha(r1,0.5);

plot(timeax,squeeze(r(pop,:,5)),'b','LineWidth',0.5);
plot(timeax,squeeze(r(pop,:,4)),'r','LineWidth',0.5);


hold off;
% axis([0 4 3.5 4.1]);
xlabel("Time (s)");
ylabel("FR (Hz)");

% x0 = 0; y0 = 0; width = 4.5; height = 2;
% set(gcf,'units','centimeters','position',[x0,y0,width,height]);
% set(gca, 'FontName', 'Arial');
% set(gca,'FontSize',8);
% filename = append(filepath,'tc_plus_L23E');
% print(filename, '-dpng', '-r600');
% print(filename', '-dsvg', '-r600');