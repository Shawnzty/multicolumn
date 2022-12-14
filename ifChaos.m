[pksR,locsR] = findpeaks(r(5,:,4));
[pksV,locsV] = findpeaks(v(5,:,4));

figure();
plot(locsV,-pksV,'r');

hold on
plot(locsR,pksR,'b');
% xline(locsV,'r');
% xline(locsR,'b');
set(gca, 'YScale', 'log');
% ylim([-100 100]);
