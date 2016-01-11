clear all;
addpath('/usr/class/ee214/matlab/hspice_toolbox')

h = loadsig('example_214.sw0');
lssig(h)

idn = evalsig(h,'i_mn1');
idp = evalsig(h,'i_mp1');
vds = evalsig(h,'ds');

figure(1);
plot(vds, idn, 'linewidth', 2);
set(gca,'FontSize',14);
title('NMOS')
xlabel('V_D_S [V]');
ylabel('I_D [A]');
grid;
saveas(gcf,'nmos.png')

figure(2);
plot(vds, idp, 'linewidth', 2);
set(gca,'FontSize',14);
title('PMOS')
xlabel('-V_D_S [V]');
ylabel('I_D [A]');
grid;
saveas(gcf,'pmos.png')

