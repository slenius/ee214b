%addpath('/usr/class/ee214b/matlab');

close all
clear all

load 180nch.mat
load 180pch.mat

% part e
f_spice = 908e6;
f_spec = 1.1e9;
k = 1 / (2-f_spec/f_spice);

gm_id_k = 4.392e-3/547e-6;

% Specs
c_l = 500e-15;
w_3db = 2*pi*f_spec;
a_v0 = 1;

% Constraints
mp.gm_id = 8;
mn.gm_id = a_v0 * mp.gm_id;
mp.l = 0.24e-6;
mn.l = 0.24e-6;

% Initialize
iters = 5;
c_self(1) = 0;

for i = 1:iters
    % compute gm and ID for given specs
    c_tot(i) = c_l + c_self(i);
    gm_p(i) = w_3db*c_tot(i);
    id(i) = gm_p(i)/mp.gm_id;
    
    mn.id = id(i);
    mp.id = id(i);
    mn.gm = gm_p(i);
    mp.gm = gm_p(i);
    mn.wt = lookup(nch, 'GM_CGG', 'GM_ID', mn.gm_id, 'L', mn.l*1e6);
    mp.wt = lookup(pch, 'GM_CGG', 'GM_ID', mn.gm_id, 'L', mn.l*1e6);
    
    % compute device widths
    w_n(i) = id(i) ./ lookup(nch, 'ID_W', 'GM_ID', mn.gm_id, 'L', mn.l*1e6);
    w_p(i) = id(i) ./ lookup(pch, 'ID_W', 'GM_ID', mp.gm_id, 'L', mp.l*1e6);
    
    mn.w = w_n(i)/1e6;
    mp.w = w_p(i)/1e6;
    
    % compute self-loading capacitance for next iteration
    %c_dbn(i) = w_n(i)*(1 - lookup(nch, 'CGD_CDD', 'GM_ID', mn.gm_id, 'L', L)) ...
    %    * lookup(nch, 'CDD_W', 'GM_ID', mn.gm_id, 'L', L);
    %--------
    % Your code here. Hint: three capacitances are relevant.
    %Cself(i+1) = Cdbn(i) + 
    mn = calc_caps(nch, mn);
    mp = calc_caps(pch, mp);
    
    c_self(i+1) = mn.cdb + mp.cdb + mp.cgs;
    
    
    
    %--------
end

iss = id * 2;

figure;
plot(iss*1e6, 'b*-');
xlabel('Iteration');
ylabel('Iss (uA)');
title('Iss Current Annealing - HW4 P3h');