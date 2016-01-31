addpath('/usr/class/ee214b/matlab');

load 180nch.mat
load 180pch.mat

% Specs
CL = 500e-15;
w3dB = 2*pi*1.1e9;
Av = 1;

% Sweep
gmIDp = linspace(5, 20, 100);
gmIDn = Av*gmIDp;

% Constraints
L = 0.24;

iters = 5;
for k = 1:length(gmIDp)
    % Initialize
    Cself(1, k) = 0;
    for i = 1:iters
        % compute gm and ID for given specs
        Ctot(i, k) = CL + Cself(i, k);
        gmp(i, k) = w3dB*Ctot(i, k);
        gmn(i, k) = Av*gmp(i, k);
        ID(i, k) = gmp(i, k)/gmIDp(k);

        % compute device widths
        Wn(i, k) = ID(i, k)/lookup(nch, 'ID_W', 'GM_ID', gmIDn(k), 'L', L);
        Wp(i, k) = ID(i, k)/lookup(pch, 'ID_W', 'GM_ID', gmIDp(k), 'L', L);

        % compute self-loading capacitance for next iteration
        Cdbn(i, k) = Wn(i, k)*(1 - lookup(nch, 'CGD_CDD', 'GM_ID', gmIDn(k), 'L', L)) ...
            * lookup(nch, 'CDD_W', 'GM_ID', gmIDn(k), 'L', L);

        %--------
        % Your code here. Hint: three capacitances are relevant.
        
        
        
        %--------
        Cself(i+1, k) = Cdbn(i, k) +
    end
end
    