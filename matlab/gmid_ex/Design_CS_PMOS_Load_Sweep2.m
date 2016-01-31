%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Drew Hall
% EE 214 (Winter 2011)
% 18 Jan 2011
%
% Design a common source amplifier with a PMOS load using the gm/id design
% methodology.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;
format short eng;

% Load the EE 214 technology files
load techchar.mat;

% Constraints
Pwr = 2e-3;         % Power dissipation [Watts]
Av_dB = 30;         % Gain [dB]     (Maximum 35 with this arch)
C_l = 500e-15;      % Load capacitance [Farads]
Vdd = 1.8;          % Supply Voltage [Volts]
k = 1/2;            % Ratio of (gm/id_p) / (gm/id_n);

% Primary Design Variables
gmid_n = (8:1:24);
Ln = (0.18:0.02:0.5) .* 1e-6;

Area = zeros(length(gmid_n), length(Ln));
BW = zeros(length(gmid_n), length(Ln));

% Design a bunch of different amplifiers
for i = 1:length(gmid_n)
    for j = 1:length(Ln)
        [Area(i,j), BW(i,j)] = CS_PMOS_Load(tech, Pwr, Av_dB, C_l, Vdd, k, gmid_n(i), Ln(j));
    end
end

% Plot
[X,Y] = meshgrid(Ln .* 1e6, gmid_n);

h = figure;
set(h,'Name','Bandwidth','NumberTitle','off')
set(h, 'Position', [100 100 900 500]);
axes('LineWidth',1.5,'FontWeight','bold','FontSize',10);
hold on;
set(gca, 'FontName','Arial Narrow', 'FontWeight', 'bold');
xlabel('L_n [\mum]', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Gm/Id_n [S/A]', 'FontSize', 12, 'FontWeight', 'bold');
title('BW [MHz]', 'FontSize', 14, 'FontWeight', 'bold');

surf(X,Y, BW ./ 1e6);
colormap(jet);
view([0 90]);
xlim([Ln(1) .* 1e6, Ln(end) .* 1e6]);
colorbar;

% Save the figure
set(gcf, 'Units', 'inches');
set(gcf, 'Position', [1 1 9 6]);
set(gcf, 'PaperPositionMode', 'auto');
print(h, '-dtiff', '-r150', sprintf('Plots\\BW_%.0fdB_%.1fmW.tif', Av_dB, Pwr.*1e3)); 

% Find the best design
[BW_max, idx_max] = max(BW(:));
gmid_nmax = Y(idx_max);
Ln_max = X(idx_max) ./ 1e6;

[Area_max, BW_max, Wn_max, Ln_max, Wp_max, Lp_max] = CS_PMOS_Load(tech, Pwr, Av_dB, C_l, Vdd, k, gmid_nmax, Ln_max);

% Print the results
disp(sprintf('\nDesign Summary of maximum BW'));
disp(sprintf('-----------------------------------'));
disp(sprintf('BW = %.3f MHz\t\tArea = %.3f um^2', BW_max ./1e6, Area_max));
disp(sprintf('Wn = %.3f um\t\tWp = %0.3f um', Wn_max * 1e6, Wp_max * 1e6));
disp(sprintf('Ln = %.3f um\t\tLp = %0.3f um', Ln_max * 1e6, Lp_max * 1e6));
