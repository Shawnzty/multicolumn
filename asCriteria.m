function as = asCriteria(cond1, cond2, cond3, cond4, cond5) %base on average of peak: (r,stimIn)
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
% criteria2 = cond3>cond2 && cond5>cond2;




% base on envelop
cond1 = cond1(25001:75000);
cond2 = cond2(25001:75000);
cond3 = cond3(25001:75000);
cond4 = cond4(25001:75000);
cond5 = cond5(25001:75000);

criteria1 = sum(cond1<cond3)==0 && sum(cond1<cond5)==0 && sum(cond4<cond3)==0 && sum(cond4<cond5)==0;
criteria2 = sum(cond3<cond2)==0 && sum(cond5<cond2)==0;

if criteria1 && criteria2
    as = 'asAllCriteria/';
elseif criteria1
        as = 'asCriteria1/';
elseif criteria2
        as = 'asCriteria2/';
else
    as = '';
end
end

