clear all
close all


load 180nch.mat
load 180pch.mat

c = ee214b_defaults('mos180', 300);

vdd = 1.8;

r_f = 5e3;
c_in = 10e-12;

mn.id = 200e-6;
mn.gm = 2e-3;
mn.l = .24e-6;

gamma = .85;


gm_bjt = mn.id / c.v_t;

mn.gm_id = mn.gm / mn.id;

mn.wt = lookup(nch, 'GM_CGG', 'GM_ID', mn.gm_id, 'L', mn.l*1e6, 'VDS', vdd/2);

mn.id_w = lookup(nch, 'ID_W', 'GM_ID', mn.gm_id, 'L', mn.l*1e6, 'VDS', vdd/2);
mn.gds_gm = lookup(nch, 'GDS_GM', 'GM_ID', mn.gm_id, 'L', mn.l*1e6, 'VDS', vdd/2);

mn.gds = mn.gm * mn.gds_gm;
mn.ro = 1/mn.gds;
mn.w = 1e-6 * mn.id / mn.id_w;

a_prime = -mn.gm * mn.ro;
f = -1 / r_f;

T = a_prime * f;
a_cl = a_prime / (1+T);


r_in = r_f / (1+mn.gm*mn.ro);

w1 = 1 / (r_in * c_in);
f1 = 1/ (2 * pi) * w1;


i_rt_2 = 4 * c.k * c.T / r_f;
i_dt_2 = 4 * c.k * c.T * gamma * mn.gm;
i_cs_2 = 2 * c.q * mn.id;



i_i_rt_2 = i_rt_2;
i_i_dt_2 = i_dt_2 / (mn.gm * r_in)^2;
i_i_cs_2 = i_cs_2 / (gm_bjt * a_cl)^2;