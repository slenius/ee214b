close all
clear all

load 180nch.mat

% Specs
r_l = 6e3;
c_l = 100e-15;
i_bias = 100e-6;
l = 0.18;

% part c
gm_cgs = 1/ (c_l * r_l * (49-20*sqrt(6)));

% Sweep
gm_id = linspace(5, 20, 100);

for n = 1:length(gm_id)
    w_t(n) = lookup(nch, 'GM_CGG', 'GM_ID', gm_id(n), 'L', l);
    cdd_cgg(n) = lookup(nch, 'CDD_CGG', 'GM_ID', gm_id(n), 'L', l);
    w_p1(n) = 1/(r_l*(c_l + cdd_cgg(n) * 1/w_t(n) * gm_id(n) * i_bias));

    %--------
    % Your code here. You may reuse w_t from above.
    cgg_css(n) = lookup(nch, 'CGG_CSS', 'GM_ID', gm_id(n), 'L', l);
    gmb_gm(n) = lookup(nch, 'GMB_GM', 'GM_ID', gm_id(n), 'L', l);
    w_p2(n) = w_t(n) * cgg_css(n) * (1 + gmb_gm(n));    
    
    %--------
    r(n) = w_p2(n)/w_p1(n);
end

figure;
plot(gm_id, r, 'b-');
hold on;
xlabel('gm/id')
ylabel('\omega_{p2} / \omega_{p1}')
title('Pole separation ratio vs gm/Id HW4 P5F')
ylim([0, 150]);

gm_id_100 = interp1(r, gm_id, 100);
s = sprintf('gm/Id = %0.2f', gm_id_100);
text(5.5,95, s)
s = '\omega_{p2} / \omega_{p1} = 100 \rightarrow';
text(5.5,100, s)
plot([gm_id_100 gm_id_100], [-100 100], 'k*--');


% part g;
id_w = lookup(nch, 'ID_W', 'GM_ID', gm_id_100, 'L', l)
w = i_bias / id_w
w_t = lookup(nch, 'GM_CGG', 'GM_ID', gm_id_100, 'L', l)
f_t = w_t / (2 * pi)

% part h
gm_sim = 902e-6;
id_sim = 100e-6;
cgtot_sim = 5.626e-15;

w_t_sim = gm_sim / cgtot_sim
gm_id_sim = gm_sim/id_sim

% part i
w_p1_sim = 1.61e9;
w_p2_sim = 168.8e9;
r_sim = w_p2_sim/w_p1_sim
r_error = calc_err_pct(100, r_sim)

