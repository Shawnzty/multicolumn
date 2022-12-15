figure()
bar(squeeze(PET(1,9,5,1:8,:)));
xticks([1 2 3 4 5 6 7 8]);
% xticklabels(axlabels(1:8));
% ylim([0 70]);
xlabel("From")
ylabel("Energy (\muJ)")