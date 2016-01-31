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
function [Area, BW, Wn, Ln, Wp, Lp] = CS_PMOS_Load(tech, Pwr, Av_dB, C_l, Vdd, k, gmid_n, Ln)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calculations
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Av = 10^(Av_dB/20);
    id = Pwr/Vdd;       % Use all the available current

    % Calculate the transconductances
    gm_n = gmid_n*id; 
    gmid_p = gmid_n * k;
    gm_p = gmid_p*id;

    % Calculate the length of each transistor based on the gain
    R = Av / gm_n;
    ro_n = lookup_gmro(tech, 'n', Ln, gmid_n) / gm_n;
    ro_pmin = -1*R*ro_n/(R-ro_n);                                     
    Lp = lookup_minL(tech, 'p', gmid_p, gm_p * ro_pmin); % Helper function 
    
    % Check to see if we cannot achieve this gain regardless of sizing
    if(ro_pmin <0 || isnan(Lp))
        Area = -inf; BW = -inf; Wn = 0; Ln = 0; Wp = 0; Lp = 0;
        return;
    end
    
    ro_p = lookup_gmro(tech, 'n', Lp, gmid_p) / gm_p;

    % Size the transistors
    Wn = id / lookup_idw(tech, 'n', Ln, gmid_n);
    Wp = id / lookup_idw(tech, 'p', Lp, gmid_p);

    % Calculate the capacitances
    Cgg_n = 1/(2*pi) * gm_n / lookup_ft(tech, 'n', Ln, gmid_n);
    Cgg_p = 1/(2*pi) * gm_p / lookup_ft(tech, 'p', Lp, gmid_p);

    Cdd_n = lookup_Cdd(tech, 'n', Ln, Cgg_n);
    Cdd_p = lookup_Cdd(tech, 'p', Lp, Cgg_p);
    Cgd_n = lookup_Cgd(tech, 'n', Ln, Cgg_n);
    Cgd_p = lookup_Cgd(tech, 'p', Lp, Cgg_p);

    Ctot = C_l + Cdd_n + Cdd_p; % Total capacitance at output node [F]

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Metrics
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Area = Wn*Ln + Wp*Lp;             % [um^2]
    BW = 1/(2*pi) * 1/(R*Ctot);        % [Hz]
    
return
   
    