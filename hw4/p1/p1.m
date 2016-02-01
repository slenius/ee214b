clear all
close all

load 180nch.mat
load 180pch.mat

gm_id = 8;
l = 1;

id_w_n = lookup(nch, 'ID_W', 'GM_ID', gm_id, 'L', l);
id_w_p = lookup(pch, 'ID_W', 'GM_ID', gm_id, 'L', l);

wt_n = lookup(nch, 'GM_CGG', 'GM_ID', gm_id, 'L', l);
wt_p = lookup(pch, 'GM_CGG', 'GM_ID', gm_id, 'L', l);

ft_n = wt_n / (2 * pi);
ft_p = wt_p / (2 * pi);

ft_n / 1e9
ft_p / 1e9

id_w_n * 1e6
id_w_p * 1e6

ft_ratio = ft_n / ft_p
id_ratio = id_w_n / id_w_p
