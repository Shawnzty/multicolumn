delta_e_start = 0.1; % cannot equal to 0
delta_e_end = 0.1; % can equal to 0.5
delta_i_start = 0.01; % cannot equal to 0
delta_i_end = 0.03; % can equal to 0.5
delta_steps = 101;

n = 1:delta_steps;
delta_e = delta_e_start + (n-1)*(delta_e_end-delta_e_start)/(delta_steps-1);