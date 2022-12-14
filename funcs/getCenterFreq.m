function [gamma, beta] = getCenterFreq(signal)
%GETCENTERFREQ  get the center frequency of gamma oscillation, and beta
%oscillation if exist
%   Detailed explanation goes here
    [pks,locs] = findpeaks(signal);
    mark1 = [pks(end-2), locs(end-2)];
    mark2 = [pks(end-1), locs(end-1)];
    mark3 = [pks(end), locs(end)];
    high = 100000/(mark3(2)-mark2(2));
    low = 100000/(mark3(2)-mark1(2));

    % if gamma exist
if high > 25
    gamma = high;
    % if beta exist
    if abs(mark3(1) - mark2(1)) > 0.001 && abs(mark3(1) - mark2(1)) > 5 * abs(mark3(1) - mark1(1))
        beta = low;
    else
        beta = 0;
    end
else
    gamma = 0;
    beta = high;
end
end

