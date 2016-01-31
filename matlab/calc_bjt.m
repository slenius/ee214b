function bjt = calc_bjt(c, i_c, v_b, v_c)

  bjt.i_c = i_c;
  bjt.v_b = v_b;
  bjt.v_c = v_c;
  bjt.v_e = v_b - c.psi_oe;
  
  bjt.v_ce = bjt.v_c - bjt.v_e;
  bjt.v_cb = bjt.v_c - bjt.v_b;

  
  
  bjt.gm = i_c / c.v_t;
  
  % Calculating resistances
  bjt.r_pi = c.beta_f / bjt.gm;
  bjt.r_o = c.v_a / bjt.i_c;
  bjt.r_b = c.r_b;
  bjt.r_c = c.r_c;
  
  % Calculating capacitances
  bjt.c_u = c.c_uo / (1 + bjt.v_cb / c.psi_oc)^c.n_c;
  
  bjt.c_b = c.t_f * bjt.gm;
  bjt.c_pi = bjt.c_b + 2 * c.c_jeo;
  
  


end