clear;
clc;

% candidate = [0.25, 0.5, 1, 2, 4, 8];
% for i = 1:length(candidate)
%     ratio_sens_attn = candidate(i);
%     search_reduce_L46;
% end

candidate = [0, 0.5, 1, 2, 3, 4, 8];
for i = 1:length(candidate)
    ratio_sens_attn = candidate(i);
    search_reduce_L4;
end

search_onlyA_reduce_L6;
search_SandA_reduce_L6;