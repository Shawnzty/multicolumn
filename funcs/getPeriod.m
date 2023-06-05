function [period_begin, period_finish] = getPeriod(r)
    % Input dimensions
    [nChannels, nTime, nCases] = size(r);

    % Filter parameters
    fs = 100000; % sampling rate
    fl = 20; % lower bound frequency
    fh = 40; % upper bound frequency

    % Initialize output
    period_begin = zeros(nChannels, nCases);
    period_finish = zeros(nChannels, nCases);

    % Design bandpass filter
    bpFilt = designfilt('bandpassiir','FilterOrder',20, ...
        'HalfPowerFrequency1',fl,'HalfPowerFrequency2',fh, ...
        'SampleRate',fs);

    % Loop over channels and cases
    for i = 1:nChannels
        for j = 1:nCases
            % Filter signal
            filteredSignal = filtfilt(bpFilt, r(i,:,j));
            % Find peaks
            [~,locs] = findpeaks(filteredSignal);
            % Get last period
            if numel(locs) >= 2
                period_begin(i,j) = locs(end-1);
                period_finish(i,j) = locs(end);
            end
        end
    end
end
