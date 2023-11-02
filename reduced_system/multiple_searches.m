clear;
clc;

candidate = [0.25, 0.5, 1, 2, 4, 8];
for i = 1:length(candidate)
    ratio_sens_attn = candidate(i);
    search2D;
end