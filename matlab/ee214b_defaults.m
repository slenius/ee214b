function c = ee214b_defaults(model, temp)
  c.Ks = 11.8;
  c.Kox = 3.9;
  c.ep_o = 8.854e-12; % permittivity of free space
  c.q = 1.602e-19;    % charge of electron
  c.psi_o = 0.7;
  c.T = temp;
  c.k = 1.38e-23;
  c.v_t = c.k * c.T / c.q;
 
  if strcmp(model, 'mos180')
    c.cox_n = 8.42e-15 / (1e-6)^2; %F/m^2
    c.cox_p = c.cox_n;
    
    c.c_prime_ol_n = 0.491e-15 / 1e-6; %F/m
    c.c_prime_ol_n = 0.657e-15 / 1e-6; %F/m
    
    c.c_j_n = 0.965e-15 / (1e-6)^2; %F/m^2
    c.c_j_p = 1.190e-15 / (1e-6)^2; %F/m^2
    
    c.c_jsw_n = 0.233e-15 / 1e-6; %F/m
    c.c_jsw_p = 0.192e-15 / 1e-6; %F/m
    
    c.c_j_well_p = 0.2e-15 / (1e-6)^2; %F/m^2
    
    c.pb_n = 0.8;
    c.pb_p = c.pb_n;
    
    c.mj_n = 0.38;
    c.mj_p = 0.40;
    
    c.mj_sw_n = 0.13;
    c.mj_sw_p = 0.33;
    
    c.l_dif_n = 0.64e-6;
    c.l_dif_p = c.l_dif_n;
  end
    
  if strcmp(model, 'sige_hbt')
    c.beta_f = 300;
    c.beta_r = 2;
    c.v_a = 90;
    c.i_s = 3.2e-17;
    c.i_co = 1e-12;
    c.bv_ceo = 2;
    c.bv_cbo = 5.5;
    c.bv_ebo = 3.3;
    c.t_f = 0.56e-12;
    c.t_r = 10e-12;
    c.r_b = 25;
    c.r_c = 60;
    c.r_ex = 2.5;
    c.c_jeo = 6.26e-15;
    c.psi_oe = 0.8;
    c.n_e = 0.4;
    c.c_uo = 3.42e-15;
    c.psi_oc = 0.6;
    c.n_c = 0.33;
    c.c_cso = 3e-15;
    c.psi_os = 0.6;
    c.n_s = 0.33;
  end
end