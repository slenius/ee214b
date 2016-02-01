close all
clear all

load 180nch.mat

n1.gm_id = 7;

% Specs
Av0 = -4;
Rl = 1e3;
Rs = 10e3;
Cl = 50e-15;
n1.l = 0.18e-6;

% problem sections

% a
n1.gm = -Av0 / Rl;
n1.id = n1.gm / n1.gm_id;

% b
n1.id_w = lookup(nch, 'ID_W', 'GM_ID', n1.gm_id, 'L', n1.l*1e6);
n1.w = n1.id / n1.id_w / 1e6;

% c
n1.wt = lookup(nch, 'GM_CGG', 'GM_ID', n1.gm_id, 'L', n1.l*1e6);
n1 = calc_caps(nch, n1);

t1 = n1.cgs * Rs;
t2 = n1.cgd * (1 + abs(Av0)) * Rs;
t3 = Rl * (n1.cdb + Cl);

p1_oct = 1/(2 * pi * (t1+t2+t3));

% d
const = ee214b_defaults('mos180');
col = n1.w * const.c_prime_ol_n;
cgs = 2/3 * n1.w * n1.l * const.cox_n + col;
cgd = col;
cgb = 0;
