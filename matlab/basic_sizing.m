% EE214B, basic sizing example
clear all;
close all;
%addpath(?/usr/class/ee214b/matlab');
load 180nch.mat;
% Specification
gm = 10e-3;
% Chosen inversion levels and resulting drain current
gm_id = (2:0.1:25)';
id = gm./gm_id;
% Current density and width
id_w = lookup(nch, 'ID_W', 'GM_ID', gm_id);
w = id./id_w;

% Gate Voltage
vgs = lookupVGS(nch, 'GM_ID', gm_id);

% Transit frequency and Cgg
w_t = lookup(nch, 'GM_CGG', 'GM_ID', gm_id);
c_gg = gm./w_t;
f_t = w_t / (2 * pi);

figure;
hold on;
plot(vgs, gm_id, 'b')
plot(vgs, f_t / 1e9, 'r')
plot(vgs, gm_id .* f_t / 10e9, 'g')
xlabel('vgs')
ylabel('blop')
legend('gm/id', 'ft', 'product');