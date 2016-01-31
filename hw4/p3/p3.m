addpath('/usr/class/ee214b/matlab');

load 180nch.mat
load 180pch.mat

% Specs
CL = 500e-15;
w3dB = 2*pi*1.1e9;
Av = 1;

% Constraints
gmIDp = 8;
gmIDn = Av*gmIDp;
L = 0.24;

% Initialize
iters = 5;
Cself(1) = 0;

for i = 1:iters
    % compute gm and ID for given specs
    Ctot(i) = CL + Cself(i);
    gmp(i) = w3dB*Ctot(i);
    ID(i) = gmp(i)/gmIDp;
    
    % compute device widths
    Wn(i) = ID(i)/lookup(nch, 'ID_W', 'GM_ID', gmIDn, 'L', L);
    Wp(i) = ID(i)/lookup(pch, 'ID_W', 'GM_ID', gmIDp, 'L', L);
    
    % compute self-loading capacitance for next iteration
    Cdbn(i) = Wn(i)*(1 - lookup(nch, 'CGD_CDD', 'GM_ID', gmIDn, 'L', L)) ...
        * lookup(nch, 'CDD_W', 'GM_ID', gmIDn, 'L', L);
    %--------
    % Your code here. Hint: three capacitances are relevant.
    Cself(i+1) = Cdbn(i) + 
    
    
    
    %--------
end