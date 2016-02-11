% EE214B Winter 2015
% This file generates plots of the total output noise and the integrated
% noise from .noise simulation results of HSpice.

addpath('/usr/class/ee214b/matlab/hspice_toolbox');
clear all;
close all;

% Load hspice output
HW4 = loadsig('Q3.ac0');

% List available signals
lssig(HW4)

% Read into MATLAB variables
f     = evalsig(HW4, 'HERTZ');
no    = evalsig(HW4, 'outnoise');
ni    = evalsig(HW4, 'innoise');
integ = cumtrapz(f, no);
integ_sqrt = 1e6*sqrt(integ);
integ_final = integ_sqrt(end);

% Plot the results
figure(1);
subplot(2,1,1)
loglog(f, no, 'linewidth', 2);
xlabel('f [Hz]');
ylabel('PSD [V^2/Hz]');
axis([min(f) max(f) min(no)/10 10*max(no)]);
title('Output Noise');
grid;

subplot(2,1,2)
loglog(f, ni, 'linewidth', 2);
xlabel('f [Hz]');
ylabel('PSD [V^2/Hz]');
axis([min(f) max(f) min(ni)/10 10*max(ni)]);
title('Input Noise');
grid;


figure(2)
semilogx(f, integ_sqrt,'linewidth', 2);
xlabel('f [Hz]');
ylabel('Sqrt(Integral) [\muVrms]');
axis([min(f) max(f) 0 1.2*integ_final]);
string=sprintf('Sqrt(Noise)=%2.2fuVrms', integ_final);
title(string);
grid;

