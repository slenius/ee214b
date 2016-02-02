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

%e
h = loadsig('ckt.ac0');
lssig(h)
vod = evalsig(h, 'v_vod');

mag_db = 20*log10(abs(vod));
ang = angle(vod);
freq = evalsig(h, 'HERTZ');

mag_3db = max(mag_db) - 3
freq_3db = interp1(mag_db, freq, mag_3db);


figure;

semilogx(freq, mag_db);
hold on;
plot([freq_3db, freq_3db], [-200, mag_3db], 'k--*');
grid on;
xlabel('Hertz');
ylabel('Gain (dB)');
title('Vod Frequency Response - HW4P2E');
legend('Vod', '-3dB')
ylim([-100, 20]);
s = sprintf('%02.0f MHz', freq_3db/1e6);
s = strcat('\leftarrow ', s);
text(freq_3db*1.5,mag_3db, s)


sim_bw = 359e6;
bw_err = calc_err_pct(p1_oct, sim_bw)

%f
f_i = sim_bw / (n1.id*2)

f_i_class = 215e6 / 600e-6