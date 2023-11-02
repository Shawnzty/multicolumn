
sens_conn_mat = [0.0846, 0.0629;
                 0.0363, 0.0515;
                 0.0411, 0.0057;
                 0.0209, 0.0022];
N_L4E = 10957;
N_L4I = 2739;
ratioIE_Isens = 0.0619/0.0983;
ratio_sens_attn = 3;

sens_conn_mat(:,1) = sens_conn_mat(:,1)*N_L4E;
sens_conn_mat(:,2) = sens_conn_mat(:,2)*N_L4I;
sens_conn_mat(:,2) = sens_conn_mat(:,2)*ratioIE_Isens;
sens_to_pop = sens_conn_mat(:,1) - sens_conn_mat(:,2); % E-I
sens_to_pop = sens_to_pop/max(sens_to_pop); % normalize

Isens = Iattn*ratio_sens_attn;
Isens = Isens*sens_to_pop;