finalR = zeros(16,5);
[r,v,g] = once(0.3, 0.02, 0.02, 10000);
[head, tail] = period(r,0);
for cond = 1:5
    finalR(:,cond) = squeeze(r(:,head(cond),cond));
end