function [fet] = calc_caps(data, fet)
  fet.cgg = fet.gm / fet.wt;
  fet.cgd = fet.cgg * lookup(data, 'CGD_CGG', 'GM_ID', fet.gm_id, 'L', fet.l*1e6);
  fet.cdd = fet.cgg * lookup(data, 'CDD_CGG', 'GM_ID', fet.gm_id, 'L', fet.l*1e6);
  fet.cdb = fet.cdd - fet.cgd;
  fet.cgs = fet.cgg - fet.cgd;
end