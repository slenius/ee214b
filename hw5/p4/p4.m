clear all
close all

c = ee214b_defaults('sige');

Ic = linspace(3.6556e-05, 3.6556e-03, 10000);
Rs = 1000;
B = 200;

gm = Ic ./ c.v_t;

vs = 4 .* c.k .* c.T .* ( Rs + gm.*Rs.^2./(2.*B) + 1./(2 .* gm));
vs_rms = sqrt(vs);

figure;
semilogx(Ic, vs_rms);
hold on;
plot(Ic(vs_rms==min(vs_rms)), min(vs_rms), 'k*')
xlabel('Collector Current');
ylabel('Input Referred Noise, nV/$$\sqrt{Hz}$$', 'Interpreter', 'Latex', 'FontSize',13);
title('Common Emitter Input Referred Noise - EE214B HW5 P4')

vsmin = min(vs_rms)
icmin = Ic(vs_rms==vsmin)

icminp20 = min(Ic(Ic >= icmin*1.2))
icminm20 = max(Ic(Ic <= icmin*0.8))

vsminp20 = vs_rms(Ic==icminp20)
vsminm20 = vs_rms(Ic==icminm20)


plot(icminp20 , vsminp20, 'r*')
plot(icminm20 , vsminm20, 'b*')

error_p = calc_err_pct(vsmin, vsminp20)
error_m = calc_err_pct(vsmin, vsminm20)

legend('Noise', 'Minimum', 'Min + 20%Ic', 'Min - 20%Ic');

%vs_rms(Ic()