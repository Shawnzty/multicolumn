function [location,location_env] = asCriteria(cond1, cond2, cond3, cond4, cond5, maxDurStim, Delta_e, Delta_i, Iattn) %base on average of peak: (r,stimIn)
%asCriteria return the situation of criteria obeying
%   return as= '' or 'asCriteria1/' or 'asCriteria2/' or 'asAllCriteria/'
%   criteria1 is cond 1,4 > cond 3,5
%   criteria2 is cond 3,5 > cond 2
%   stimIn = 100000 the step when stimulation start

%   base on average of peak
% rangeStart = stimIn + 10000;
% rangeEnd = length(r) - 10000;
% cond1 = mean(findpeaks(r(1,rangeStart:rangeEnd,1)));
% cond2 = mean(findpeaks(r(1,rangeStart:rangeEnd,2)));
% cond3 = mean(findpeaks(r(1,rangeStart:rangeEnd,3)));
% cond4 = mean(findpeaks(r(1,rangeStart:rangeEnd,4)));
% cond5 = mean(findpeaks(r(1,rangeStart:rangeEnd,5)));

% criteria1 = cond1>cond3 && cond1>cond5 && cond4>cond3 && cond4>cond5;
% criteria2 = cond3>cond2 && cond5>cond2 && cond1>cond2 && cond4>cond2;

% base on envelop
cond1 = cond1(60001:90000);
cond2 = cond2(60001:90000);
cond3 = cond3(60001:90000);
cond4 = cond4(60001:90000);
cond5 = cond5(60001:90000);

criteria1 = sum(cond1<cond3)==0 && sum(cond1<cond5)==0 && sum(cond4<cond3)==0 && sum(cond4<cond5)==0;
criteria2 = sum(cond1<cond2)==0 && sum(cond3<cond2)==0 && sum(cond4<cond2)==0 && sum(cond5<cond2)==0;

if criteria1 && criteria2
    % difference between conds
    cond1Mean = mean(cond1);cond3Mean = mean(cond3);cond4Mean = mean(cond4);
    diff13 = cond1Mean - cond3Mean; diff34 = cond4Mean - cond3Mean;
    ratioDiff = diff13/diff34;
    if maxDurStim > 0.01
        as = 'asAllCriteria/';
    else
        as = 'asAll_OFF/';
    end
elseif criteria1
    as = 'asCriteria1/';
    ratioDiff = 0;
elseif criteria2
    as = 'asCriteria2/';
    ratioDiff = 0;
else
    as = 'none/';
    ratioDiff = 0;
end
filename = append(num2str(Delta_e),'_',num2str(Delta_i),'_',num2str(Iattn),'_',num2str(ratioDiff),'.png');
location = append('figure/',as,filename);
location_env = append('figure/',as,'env_',filename);
end

