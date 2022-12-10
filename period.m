function [head,tail] = period(r,multiFreq)
%PERIOD Get last period
%   Detailed explanation goes here
head = zeros(5); tail = zeros(5);
if multiFreq
    idx = 2;
else
    idx = 1;
end
for i = 1:5
[pks,locs] = findpeaks(r(1,:,i));
head(i) = locs(end-idx);
tail(i) = locs(end);
end
end

