% Technoloy characterization
% Boris Murmann, 2010

% load hspice data
clear all;
addpath('/usr/class/ee214/matlab/hspice_toolbox')
h = loadsig('/usr/class/ee214/hspice/techchar.sw0');
%lssig(h)

% compute parameters
nov    = evalsig(h, 'gs') - evalsig(h, 'nth');
ngmid  = evalsig(h, 'ngm') ./ evalsig(h, 'i_mn');
nft    = evalsig(h, 'ngm') ./ evalsig(h, 'ncgg') /2/pi;
ngmgds = evalsig(h, 'ngm') ./ evalsig(h, 'ngds');
nidw   = evalsig(h, 'nidw');
ncgg   = evalsig(h, 'ncgg');
ncgd   = -evalsig(h, 'ncgd');
ncdd   = evalsig(h, 'ncdd');
ncdg   = evalsig(h, 'ncdg');
pov    = evalsig(h, 'gs') - evalsig(h, 'pth');
pgmid  = -evalsig(h, 'pgm') ./ evalsig(h, 'i_mp');
pft    = evalsig(h, 'pgm') ./ evalsig(h, 'pcgg') /2/pi;
pgmgds = evalsig(h, 'pgm') ./ evalsig(h, 'pgds');
pidw   = -evalsig(h, 'pidw');
pcgg   = evalsig(h, 'pcgg');
pcgd   = -evalsig(h, 'pcgd');
pcdd   = evalsig(h, 'pcdd');
pcdg   = evalsig(h, 'pcdg');
vgs   = evalsig(h, 'gs');
Lvector = round(1e10*evalsig(h, 'sw_length'))/1e10;
Lmin = min(Lvector);

% plot titles
string_n='NMOS, 0.18...0.5um, step=20nm';
string_p='PMOS, 0.18...0.5um, step=20nm';
% gm/id range to be considerd in plots
gmidmax=20;
gmidmin=5;
% find indexes within plot boundaries
idxn1 = find(ngmid(:,1)<gmidmax & ngmid(:,1)>gmidmin);
idxp1 = find(pgmid(:,1)<gmidmax & pgmid(:,1)>gmidmin);
idxne = find(ngmid(:,end)<gmidmax & ngmid(:,end)>gmidmin);
idxpe = find(pgmid(:,end)<gmidmax & pgmid(:,end)>gmidmin);

figure(1);
plot(nov(2:end,:), ngmid(2:end,:), nov(2:end,:), 1e-9*nft(2:end,:), 'linewidth', 2);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
set(gca,'LineWidth',1);
title(string_n);
v = axis;
axis([-0.25 0.5 v(3) v(4)]);
xlabel('V_G_S-V_t  [V]');
ylabel('g_m/I_D, f_T [A/S, GHz]');
grid minor;
grid;
figure(2);
plot(pov(2:end,:), pgmid(2:end,:), pov(2:end,:), 1e-9*pft(2:end,:), 'linewidth', 2);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
set(gca,'LineWidth',1);
title(string_p);
v = axis;
axis([-0.25 0.5 v(3) v(4)]);
xlabel('V_G_S-V_t  [V]');
ylabel('g_m/I_D, f_T [A/S, GHz]');
grid minor;
grid;

figure(3);
plot(ngmid, 1e-9*nft, 'linewidth', 2);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
set(gca,'LineWidth',1);
title(string_n);
ymin = min([ 1e-9*nft(idxn1,1); 1e-9*nft(idxne,end) ]);
ymax = max([ 1e-9*nft(idxn1,1); 1e-9*nft(idxne,end) ]);
axis([gmidmin gmidmax ymin ymax]);
xlabel('g_m/I_D [S/A]');
ylabel('f_T [GHz]');
grid minor;
grid;
figure(4);
plot(pgmid, 1e-9*pft, 'linewidth', 2);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
set(gca,'LineWidth',1);
title(string_p);
ymin = min([ 1e-9*pft(idxp1,1); 1e-9*pft(idxpe,end) ]);
ymax = max([ 1e-9*pft(idxp1,1); 1e-9*pft(idxpe,end) ]);
axis([gmidmin gmidmax ymin ymax]);
xlabel('g_m/I_D [S/A]');
ylabel('f_T [GHz]');
grid minor;
grid;

figure(5);
semilogy(ngmid, nidw, 'linewidth', 2);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
set(gca,'LineWidth',1);
title(string_n);
ymin = min([ nidw(idxn1,1); nidw(idxne,end) ]);
ymax = max([ nidw(idxn1,1); nidw(idxne,end) ]);
axis([gmidmin gmidmax ymin ymax]);
xlabel('g_m/I_D  [S/A]');
ylabel('I_D/W [A/m]');
grid minor;
grid;
figure(6);
semilogy(pgmid, pidw, 'linewidth', 2);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
set(gca,'LineWidth',1);
title(string_p);
ymin = min([ pidw(idxp1,1); pidw(idxpe,end) ]);
ymax = max([ pidw(idxp1,1); pidw(idxpe,end) ]);
axis([gmidmin gmidmax ymin ymax]);
xlabel('g_m/I_D  [S/A]');
ylabel('I_D/W [A/m]');
grid minor;
grid;

figure(7);
plot(ngmid, ngmgds, 'linewidth', 2);
set(gca,'LineWidth',1);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
title(string_n);
ymin = min([ ngmgds(idxn1,1); ngmgds(idxne,end) ]);
ymax = max([ ngmgds(idxn1,1); ngmgds(idxne,end) ]);
axis([gmidmin gmidmax ymin ymax]);
xlabel('g_m/I_D  [S/A]');
ylabel('g_m/g_d_s');
grid minor;
grid;
figure(8);
plot(pgmid, pgmgds, 'linewidth', 2);
set(gca,'LineWidth',1);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
title(string_p);
ymin = min([ pgmgds(idxp1,1); pgmgds(idxpe,end) ]);
ymax = max([ pgmgds(idxp1,1); pgmgds(idxpe,end) ]);
axis([gmidmin gmidmax ymin ymax]);
xlabel('g_m/I_D  [S/A]');
ylabel('g_m/g_d_s');
grid minor;
grid;

figure(9);
ngm_id_ft = ngmid.*nft*1e-9;
plot(ngmid, ngm_id_ft, 'linewidth', 2);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
set(gca,'LineWidth',1);
title(string_n);
ymin = min([ ngm_id_ft(idxn1,1); ngm_id_ft(idxne,end) ]);
ymax = max([ ngm_id_ft(idxn1,1); ngm_id_ft(idxne,end) ]);
axis([gmidmin gmidmax ymin 1.05*ymax]);
xlabel('g_m/I_D  [S/A]');
ylabel('g_m/I_D*f_T [GHz*S/A]');
grid minor;
grid;
figure(10);
pgm_id_ft = pgmid.*pft*1e-9;
plot(pgmid, pgm_id_ft, 'linewidth', 2);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
set(gca,'LineWidth',1);
title(string_p);
ymin = min([ pgm_id_ft(idxp1,1); pgm_id_ft(idxpe,end) ]);
ymax = max([ pgm_id_ft(idxp1,1); pgm_id_ft(idxpe,end) ]);
axis([gmidmin gmidmax ymin ymax]);
xlabel('g_m/I_D  [S/A]');
ylabel('g_m/I_D*f_T [GHz*/A]');
grid minor;
grid;

% find cgd_cgg at gm/ID = 10, as a function of L
ncgd_cgg_mat = ncgd./ncgg;
ncdd_cgg_mat = ncdd./ncgg;
pcgd_cgg_mat = pcgd./pcgg;
pcdd_cgg_mat = pcdd./pcgg;
for i = 1:length(Lvector)
    ncgd_cgg(i) = interp1(ngmid(:,i), ncgd_cgg_mat(:,i), 10);
    ncdd_cgg(i) = interp1(ngmid(:,i), ncdd_cgg_mat(:,i), 10);
    pcgd_cgg(i) = interp1(pgmid(:,i), pcgd_cgg_mat(:,i), 10);
    pcdd_cgg(i) = interp1(pgmid(:,i), pcdd_cgg_mat(:,i), 10);
end
    
figure(11);
plot(1e6*Lvector, ncgd_cgg, 1e6*Lvector, ncdd_cgg, '--', 'linewidth', 2);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
set(gca,'LineWidth',2);
title('NMOS, g_m/I_D=10S/A, V_D_S=0.9V');
axis([min(1e6*Lvector) max(1e6*Lvector), 0 0.8]);
xlabel('L  [\mum]');
legend('C_g_d/C_g_g', 'C_d_d/C_g_g')
grid;
figure(12);
plot(1e6*Lvector, pcgd_cgg, 1e6*Lvector, pcdd_cgg, '--', 'linewidth', 2);
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
set(gca,'LineWidth',2);
title('PMOS, g_m/I_D=10S/A, V_D_S=0.9V');
axis([min(1e6*Lvector) max(1e6*Lvector), 0 0.8]);
xlabel('L  [\mum]');
legend('C_g_d/C_g_g', 'C_d_d/C_g_g')
grid;
    
% cgd per width (useful for accurate calculation of neutralization caps)
tech.ncgd_w = 0.4809e-9;
tech.pcgd_w = 0.6439e-9;

% thermal noise factor
tech.gamma = 2/3;

% rough mobility ratio
tech.mun_mup = 2.5;

tech.Lvector = Lvector;
tech.ngmid = ngmid;
tech.nft   = nft;
tech.ngmgds = ngmgds;
tech.nidw   = nidw;
tech.pgmid = pgmid;
tech.pft   = pft;
tech.pgmgds = pgmgds;
tech.pidw   = pidw;
tech.Lvector = Lvector;
tech.vgs = vgs;

tech.ncgd_cgg = ncgd_cgg;
tech.ncdd_cgg = ncdd_cgg;
tech.pcgd_cgg = pcgd_cgg;
tech.pcdd_cgg = pcdd_cgg;

save techchar_vgs.mat tech

    
