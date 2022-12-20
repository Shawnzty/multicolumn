%% plot omega~eta
% omega = sqrt(Delta_E.^2 + (Delta_I - b).^2);
% get eta (diff)
rootFolder = "figure_linReg/";
data = readFilename(rootFolder+"agree/*_*_*_*_*_*.png",'%f_%f_%f_%f_%f_%f');
data( all(~data,2), : ) = [];
diff = 2;
idx = data(:,4) < diff & data(:,4) > 1/diff;
roi = data(idx,:);
omega = sqrt(roi(:,1).^2 + (roi(:,2) - b).^2);
eta = 1./roi(:,4);
scatter(omega, eta, 10, 'filled');
xlabel("\omega");
ylabel("\eta");
axis([0 0.5 0 diff]);
