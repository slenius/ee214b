clear all
close all

load 180nch.mat;
load 180pch.mat

% basic sizing for gm/ID~10S/A, assuming default VDS (0.9V)
IB = 1e-3;
JDp = lookup(pch, 'ID_W', 'GM_ID', 10);
Wp1 = IB/JDp; Wp2=Wp1;