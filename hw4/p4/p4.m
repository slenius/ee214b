clear all
close all

load 180nch.mat
load 180pch.mat

%j
h = loadsig('p4.ac0');
lssig(h)
vod = evalsig(h, 'v_vod');

mag_db = 20*log10(abs(vod));
ang = angle(vod);
freq = evalsig(h, 'HERTZ');

mag_3db = max(mag_db) - 3;
freq_3db = interp1(mag_db, freq, mag_3db);

figure;

semilogx(freq, mag_db);
hold on;
plot([freq_3db, freq_3db], [-200, mag_3db], 'k--*');
grid on;
xlabel('Hertz');
ylabel('Gain (dB)');
title('Vod Frequency Response - HW4P4');
legend('Vod', '-3dB')
ylim([-60, 20]);
s = sprintf('%02.0f MHz', freq_3db/1e6);
s = strcat('\leftarrow ', s);
text(freq_3db*1.5,mag_3db, s)


% Specs
f_spec = 1.1e9;
c_l = 500e-15;
w_3db = 2*pi*f_spec;
a_v0 = 1;
l = 0.24;

% Constraints
gm_id_p = linspace(5, 20, 100);
gm_id_n = a_v0 * gm_id_p;
mp.l = l/1e6;
mn.l = l/1e6;

% Initialize
iters = 5;
c_self(1) = 0;

iters = 5;
for k = 1:length(gm_id_p)
    % Initialize
    c_self(1, k) = 0;
    for i = 1:iters
        % compute gm and ID for given specs
        c_tot(i, k) = c_l + c_self(i, k);
        gm_p(i, k) = w_3db * c_tot(i, k);
        gm_n(i, k) = a_v0 * gm_p(i, k);
        i_d(i, k) = gm_p(i, k) / gm_id_p(k);

        % compute device widths
        w_n(i, k) = i_d(i, k)/lookup(nch, 'ID_W', 'GM_ID', gm_id_n(k), 'L', l);
        w_p(i, k) = i_d(i, k)/lookup(pch, 'ID_W', 'GM_ID', gm_id_p(k), 'L', l);

        mp.gm_id = gm_id_p(k);
        mn.gm_id = a_v0 * mp.gm_id;
        mn.id = i_d(i, k);
        mp.id = i_d(i, k);
        mn.gm = gm_p(i, k);
        mp.gm = gm_p(i, k);
        mn.wt = lookup(nch, 'GM_CGG', 'GM_ID', mn.gm_id, 'L', mn.l*1e6);
        mp.wt = lookup(pch, 'GM_CGG', 'GM_ID', mn.gm_id, 'L', mn.l*1e6);
        
        % compute self-loading capacitance for next iteration
        mn = calc_caps(nch, mn);
        mp = calc_caps(pch, mp);
    
        c_self(i+1, k) = mn.cdb + mp.cdb + mp.cgs;
    end
end

i_ss = i_d * 2;
i_ss_fin = i_ss(iters, :);
idx = find(i_ss_fin == min(i_ss_fin));
best_gm_id = gm_id_p(idx);

figure;
plot(gm_id_p, i_ss_fin*1e6, '-');
hold on;
plot(gm_id_p(idx), i_ss_fin(idx)*1e6, 'k*')
xlabel('gm/Id');
ylabel('Iss (uA)');
title('Required Iss vs gm/Id HW4P4B');
ylim([0, max(i_ss_fin)*1e6]);
grid on;
legend('Required Iss', 'Best gm/Id')
s = sprintf('gm/Id = %02.2f', best_gm_id);
text(best_gm_id,i_ss_fin(idx)*1e6*0.8, s)


fprintf('Iss = %0.3fuA\n', i_ss_fin(idx)*1e6);
fprintf('w_p = %0.3fum\n', w_p(iters, idx));
fprintf('w_n = %0.3fum\n', w_n(iters, idx));

