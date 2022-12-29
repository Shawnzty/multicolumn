strt_prd = 400000;
end_prd = 1000000;
p_base = [0.1184, 0.1552, 0.0846, 0.0629, 0.0323, 0.0000, 0.0076, 0.0000;
          0.1008, 0.1371, 0.0363, 0.0515, 0.0755, 0.0000, 0.0042, 0.0000;
          0.0077, 0.0059, 0.0519, 0.1453, 0.0067, 0.0003, 0.0453, 0.0000;
          0.0691, 0.0029, 0.1093, 0.1597, 0.0033, 0.0000, 0.1057, 0.0000;
          0.1017, 0.0622, 0.0411, 0.0057, 0.0758, 0.3765, 0.0204, 0.0000;
          0.0436, 0.0269, 0.0209, 0.0022, 0.0566, 0.3158, 0.0086, 0.0000;
          0.0156, 0.0066, 0.0211, 0.0166, 0.0572, 0.0197, 0.0401, 0.2252;
          0.0364, 0.0010, 0.0034, 0.0005, 0.0277, 0.0080, 0.0658, 0.1443]; % intracolumn connection probability % [Wagatsuma 2011]
p = [p_base, zeros(8,8); zeros(8,8), p_base];
p(2,9) = 0.1;
p(10,1) = 0.1;

PET = getPET(v(:,strt_prd:end_prd,:),g(:,:,strt_prd:end_prd,:),p);

%% bar chart
y = [];
for i = 1:5
    twoOne = squeeze(PET(2,9,i));
    oneTwo = squeeze(PET(10,1,i));
    y = [y; twoOne oneTwo];
end
figure();
bar(y);
ylim([19 20]);
xticklabels(["Cond1", "Cond2", "Cond3", "Cond4", "Cond5"]);
ylabel("Energy Transmission in lateral pathway");
legend("C2 to C1","C1 to C2")
