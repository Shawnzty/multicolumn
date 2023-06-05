addpath('../funcs');
strt_prd = 350001; end_prd = 400000;

[r, v, g] = once(0.2, 0.02, 0.02, 4000);

[period_begin, period_finish] = getPeriod(r);
