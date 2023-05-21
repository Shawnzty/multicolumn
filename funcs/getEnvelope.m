function env = getEnvelope(signal)
%GETENVELOPE get the peak of signal and concatenate them
% signal is [16,time,5]
% directly use matlab envelope may be better?
env = zeros(16,size(signal,2),5);
stimIn = 100000;
for pop = 1:16
for cond = 1:5
    [pks,locs] = findpeaks(signal(pop,:,cond));
    xq_beforeStim = 1:stimIn;
    xq_afterStim = (stimIn+1):size(signal,2);

    before_locs = locs(locs<stimIn);
    before_pks = pks(locs<stimIn);
    after_locs = locs(locs>stimIn);
    after_pks = pks(locs>stimIn);
    
    before_locs = [before_locs, stimIn];
    before_pks = [before_pks, before_pks(end)];
    after_locs = [stimIn+1, after_locs];
    after_pks = [before_pks(end), after_pks];

    vq_beforeStim = interp1(before_locs, before_pks, xq_beforeStim);
    vq_afterStim = interp1(after_locs, after_pks, xq_afterStim);
    tmp = cat(2, vq_beforeStim, vq_afterStim);
    env(pop,:,cond) = tmp;
end
end

end

