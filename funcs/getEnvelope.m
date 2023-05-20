function env = getEnvelope(signal)
%GETENVELOPE get the peak of signal and concatenate them
% signal is [16,time,5]
env = zeros(16,size(signal,2),5);
for pop = 1:16
for cond = 1:5
    [pks,locs] = findpeaks(signal(pop,:,cond));
    xq = 1:size(signal,2);
    vq = interp1(locs, pks, xq);
    env(pop,:,cond) = vq;
end
end

end

