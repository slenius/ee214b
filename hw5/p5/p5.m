clear all
close all

c = ee214b_defaults('sige', 300);

Ic = 1e-3;
Id = Ic;

Rs = logspace(2, 5, 1000);

rb = 0;
B = 300;
G = 0.85

gm_id = 15;

gm_mos = Id * gm_id;
gm_bjt = Ic / c.v_t;

rb = Rs + 25;

noise_mos = 4 .* c.k .* c.T .* (Rs + G/gm_mos);
noise_bjt = 4 .* c.k .* c.T .* (rb + gm_bjt .* (rb).^2 ./ (2 .* B) + 1./(2 * gm_bjt));

noise_bjt_rms = sqrt(noise_bjt);
noise_mos_rms = sqrt(noise_mos);

figure;
loglog(Rs, noise_bjt_rms, 'b');
hold on;
loglog(Rs, noise_mos_rms, 'r');
xlabel('Source Resistance');
ylabel('Input Referred Noise, nV/$$\sqrt{Hz}$$', 'Interpreter', 'Latex', 'FontSize',13);
title('BJT Vs MOSFET Noise')




maxr = max(Rs(noise_bjt < noise_mos))

plot(Rs(Rs==maxr), noise_bjt_rms(Rs==maxr), 'k*')

legend('BJT Noise', 'MOSFET Noise', 'Resistance Crossover')


a = gm_bjt/(2 * B);
b = 1;
c = 1/(2 * gm_bjt) - G/gm_mos;

p = [a b c];
r = roots(p);
