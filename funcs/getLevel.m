function level = getLevel(signal, tFrom, tTo)
%GETLEVEL get the level of signal for each population under each condition
% signal looks like [16, time, 5]

level = zeros(16,6);

for pop = 1:16
for i = 1:6 % 1 is before Stim, 2 is cond 1, 3 is cond 2...
    if i == 1
        [pks,locs] = findpeaks(signal(pop,:,1));
        if std(pks(6:20))/mean(pks(6:20)) > 0.1
            [pks,locs1] = findpeaks(pks);
            locs = locs(locs1);
        end
        pks_before = pks(locs<100000);
        level(pop,i) = mean(pks_before(end-5:end));
    else
        cond = i-1;
        [pks,locs] = findpeaks(signal(pop,:,cond));
        if std(pks(6:20))/mean(pks(6:20)) > 0.1
            % disp(append("Pop number: ",num2str(pop),", Condition number:", num2str(cond-1),", ENTERED second round findpeaks."))
            [pks,locs1] = findpeaks(pks);
            locs = locs(locs1);
        end
        pks_toUse = pks((locs>tFrom) & (locs<tTo));
        level(pop,i) = mean(pks_toUse);
    end
end
end

end

