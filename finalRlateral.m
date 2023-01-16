clear;
close all;
clc;
initime = clock;

addpath('funcs');

Delta_E = 0.3; Delta_I = 0.026; Iattn = 0.02;
allTime = 5000;

steps = 101;
lateral_start = 0.09; lateral_end = 0.18;
strt_prd = 300000; end_prd = allTime/0.01;

% container
PETAsheet = zeros(steps,16,16,5);
PETOsheet = zeros(steps,16,16,5);
finalRsheet = zeros(steps,16,5);

% main
parfor n = 1:steps
    startTime = clock;
    lateral = lateral_start + (n-1)*(lateral_end-lateral_start)/(steps-1);
    [r,v,g] = onceLateral(Delta_E, Delta_I, Iattn, allTime, lateral);
    PETAsheet(n,:,:,:) = getPET(v(:,strt_prd:end_prd,:), g(:,:,strt_prd:end_prd,:));
    [head, tail] = period(r,0);
    for cond = 1:5
        dur = (tail(cond) - head(cond))*0.001*0.01;
        tmp = getPET(v(:,head(cond):tail(cond),:), g(:,:,head(cond):tail(cond),:));
        PETOsheet(n,:,:,cond) =  tmp(:,:,cond) ./ dur;
        finalRsheet(n,:,cond) = squeeze(r(:,head(cond),cond));
    end
    disp(etime(clock, startTime));
end

filename = append('finalR_cLateral_',num2str(lateral_start),'_',num2str(lateral_end),'_DeltaE_',...
    num2str(Delta_E),'_DeltaI_',num2str(Delta_I), '_Iattn_', num2str(Iattn), '.mat');
save(filename,'PETAsheet','PETOsheet','finalRsheet'); 
disp(etime(clock, initime)/60);