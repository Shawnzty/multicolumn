clear;
close all;
clc;
initime = clock;

addpath('funcs');

Delta_E = 0.3; Delta_I = 0.032; lateral = 0.1;
allTime = 4000;

steps = 201;
Iattn_start = 0.1; Iattn_end = 0.5;
strt_prd = 300000; end_prd = allTime/0.01;

% container
PETAsheet = zeros(steps,16,16,5);
PETOsheet = zeros(steps,16,16,5);
finalRsheet = zeros(steps,16,5);
% ratiosheet = zeros(steps,1);

% main
% par-9 ok
parfor n = 1:steps
    startTime = clock;
    Iattn = Iattn_start + (n-1)*(Iattn_end-Iattn_start)/(steps-1);
    disp("Computing -- lateral:"+num2str(lateral));
    [r,v,g] = onceLateral(Delta_E, Delta_I, Iattn, allTime, lateral);
    PETAsheet(n,:,:,:) = getPET(v(:,strt_prd:end_prd,:), g(:,:,strt_prd:end_prd,:));
    [head, tail] = period(r,0);
    for cond = 1:5
        dur = (tail(cond) - head(cond))*0.001*0.01;
        tmp = getPET(v(:,head(cond):tail(cond),:), g(:,:,head(cond):tail(cond),:));
        PETOsheet(n,:,:,cond) =  tmp(:,:,cond) ./ dur;
        finalRsheet(n,:,cond) = squeeze(r(:,head(cond),cond));
    end
    % ratio
%     r_cond1 = r(5,end-100000:end,1)';
%     r_cond3 = r(5,end-100000:end,3)';
%     r_cond4 = r(5,end-100000:end,4)';
%     envMthd = 'peak'; envWdo = 4000;
%     [r_cond1, ] = envelope(r_cond1,envWdo,envMthd);
%     [r_cond3, ] = envelope(r_cond3,envWdo,envMthd);
%     [r_cond4, ] = envelope(r_cond4,envWdo,envMthd);
%     diff13 = r_cond1(end-1) - r_cond3(end-1); diff43 = r_cond4(end-1) - r_cond3(end-1);    
%     ratiosheet(n,1) = diff43/diff13;
     disp(etime(clock, startTime));
end

filename = append('Iattn_cLateral_',num2str(Iattn_start),'_',num2str(Iattn_end),'_DeltaE_',...
    num2str(Delta_E),'_DeltaI_',num2str(Delta_I), '_lateral_', num2str(lateral),'_steps_',num2str(steps), '.mat');
save(filename,'PETAsheet','PETOsheet','finalRsheet'); 
disp(etime(clock, initime)/60);