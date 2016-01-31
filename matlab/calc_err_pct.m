function err_pct = calc_err_pct(hand_val, spice_val)
  err = hand_val - spice_val;
  err_pct = 100 .* err ./ spice_val;
end