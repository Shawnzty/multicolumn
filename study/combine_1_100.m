clear;
tPET = zeros(100,16,16,50000,5);
for i = 51:100
    load_data = load(append("../../data/tPET_0.22_0.42_0.034_0.034_Iattn_0.02/",num2str(i),".mat"),"tPET");
    tPET(i-50,:,:,:,:) = load_data.tPET;
    clearvars load_data;
    disp(append(num2str(i), " done"));
end
disp("Saving...")
save('..\..\data\tPET_0.22_0.42_0.034_0.034_Iattn_0.02\tPET_51_100.mat', 'tPET', '-v7.3');
save("Save done.")