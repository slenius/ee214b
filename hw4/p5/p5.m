addpath('/usr/class/ee214b/matlab');

load 180nch.mat

% Specs
RL = 6e3;
CL = 100e-15;
IBIAS = 100e-6;
L = 0.18;

% Sweep
gmID = linspace(5, 20, 100);

for n = 1:length(gmID)
    w_t = lookup(nch, 'GM_CGG', 'GM_ID', gmID(n), 'L', L);
    CDD_CGG = lookup(nch, 'CDD_CGG', 'GM_ID', gmID(n), 'L', L);
    wp1(n) = 1/(RL*(CL + CDD_CGG * 1/w_t * gmID(n) * IBIAS));
    %--------
    % Your code here. You may reuse w_t from above.
    
    
    
    wp2(n) = 
    %--------
    r(n) = wp2(n)/wp1(n);
end